import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/features/home/data/model/user_model.dart';
import 'package:expense_tracker/features/home/data/request/remote/auth_remote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemote)
class AuthRemoteImpl extends AuthRemote {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final GoogleSignIn googleSignIn;

  AuthRemoteImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.googleSignIn,
  });

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

      final doc = await firebaseFirestore
          .collection('users')
          .doc(credential.user!.uid)
          .get();

      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data()!);
      }

      return UserModel(
        fullName: credential.user!.displayName,
        email: credential.user!.email,
        uId: credential.user!.uid,
        createdAt: DateTime.now(),
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
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
      await credential.user?.updateDisplayName(fullName);

      final user = UserModel(
        fullName: fullName,
        email: email,
        uId: credential.user!.uid,
        createdAt: DateTime.now(),
      );

      await firebaseFirestore
          .collection('users')
          .doc(user.uId)
          .set(user.toMap());

      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) throw Exception("Sign in aborted by user");

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await firebaseAuth.signInWithCredential(credential);
      final User? firebaseUser = userCredential.user;

      if (firebaseUser == null) throw Exception("Firebase user is null");

      final doc = await firebaseFirestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data()!);
      }

      final user = UserModel(
        fullName: firebaseUser.displayName,
        email: firebaseUser.email,
        uId: firebaseUser.uid,
        createdAt: DateTime.now(),
      );

      await firebaseFirestore
          .collection('users')
          .doc(user.uId)
          .set(user.toMap());

      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
