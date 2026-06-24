import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/core/errors/app_exceptions.dart';
import 'package:expense_tracker/features/auth/data/model/user_model.dart';
import 'package:expense_tracker/features/auth/data/request/remote/auth_remote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemote)
class AuthRemoteImpl extends AuthRemote {
  final FirebaseAuth firebaseAuth;

  final FirebaseFirestore firebaseFirestore;

  AuthRemoteImpl({required this.firebaseAuth, required this.firebaseFirestore});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;

      if (firebaseUser == null) {
        throw RemoteException(message: 'User not found');
      }
      final doc = await firebaseFirestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();
      if (!doc.exists || doc.data() == null) {
        throw Exception('User data not found');
      }
      return UserModel.fromJson(doc.data()!);
    } on FirebaseAuthException catch (e) {
      throw RemoteException(message: e.message ?? 'Login failed');
    }
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw RemoteException(message: 'Google sign in was cancelled');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await firebaseAuth
          .signInWithCredential(credential);

      final User? firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        throw RemoteException(message: 'Failed to sign in with Google');
      }

      final bool isRegister =
          userCredential.additionalUserInfo?.isNewUser ?? false;

      final userDoc = firebaseFirestore
          .collection('users')
          .doc(firebaseUser.uid);

      if (isRegister) {
        final userModel = UserModel(
          uid: firebaseUser.uid,
          fullName: firebaseUser.displayName,
          email: firebaseUser.email,
          createdAt: DateTime.now().toIso8601String(),
        );

        await userDoc.set(userModel.toJson());

        return userModel;
      }

      final docSnapshot = await userDoc.get();

      if (docSnapshot.exists && docSnapshot.data() != null) {
        return UserModel.fromJson(docSnapshot.data()!);
      }

      final userModel = UserModel(
        uid: firebaseUser.uid,
        fullName: firebaseUser.displayName,
        email: firebaseUser.email,
        createdAt: DateTime.now().toIso8601String(),
      );

      await userDoc.set(userModel.toJson());

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw RemoteException(message: e.message ?? 'Google sign in failed');
    } catch (e) {
      throw RemoteException(message: e.toString());
    }
  }

  @override
  Future<UserModel> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;

      if (firebaseUser == null) {
        throw RemoteException(message: 'User not created');
      }

      await firebaseUser.updateDisplayName(fullName);

      final user = UserModel(
        uid: firebaseUser.uid,
        fullName: fullName,
        email: email,
        createdAt: DateTime.now().toIso8601String(),
      );

      await firebaseFirestore
          .collection('users')
          .doc(firebaseUser.uid)
          .set(user.toJson());

      return user;
    } on FirebaseAuthException catch (e) {
      throw RemoteException(message: e.message ?? 'Sign up failed');
    }
  }
}
