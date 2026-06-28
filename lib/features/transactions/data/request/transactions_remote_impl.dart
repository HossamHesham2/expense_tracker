import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/core/constants/app_constant.dart';
import 'package:expense_tracker/core/errors/app_exceptions.dart';
import 'package:expense_tracker/core/models/transaction_model.dart';
import 'package:expense_tracker/features/transactions/data/request/transactions_remote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TransactionsRemote)
class TransactionsRemoteImpl extends TransactionsRemote {
  final FirebaseAuth firebaseAuth;

  final FirebaseFirestore firebaseFirestore;

  TransactionsRemoteImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        throw RemoteException(message: "User not found please sign in");
      }
      final docRef = await firebaseFirestore
          .collection(AppConstant.usersCollection)
          .doc(user.uid)
          .collection(AppConstant.transactionsCollection)
          .orderBy('createdAt', descending: true)
          .get();
      final transactions = docRef.docs
          .map((doc) => TransactionModel.fromJson(doc.data()))
          .toList();
      return transactions;
    } catch (e) {
      throw RemoteException(message: e.toString());
    }
  }
}
