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
      print("Get User: ${user.uid}");

      for (final doc in docRef.docs) {
        print("Doc ID: ${doc.id}");
        print(doc.data());
      }
      return transactions;
    } catch (e) {
      throw RemoteException(message: e.toString());
    }
  }

  @override
  Future<TransactionModel> editTransaction({
    required String id,
    required String title,
    required double amount,
    required String category,
    required TransactionType transactionType,
    required AccountType accountType,
    required DateTime date,
    required String? note,
  }) async {
    try {
      final user = firebaseAuth.currentUser;

      if (user == null) {
        throw RemoteException(message: 'User not authenticated');
      }

      final userId = user.uid;

      final docRef = firebaseFirestore
          .collection(AppConstant.usersCollection)
          .doc(userId)
          .collection(AppConstant.transactionsCollection)
          .doc(id);
      print("Edit User: $userId");
      print("Edit Doc: $id");
      final transactionModel = TransactionModel(
        id: id,
        title: title,
        amount: amount,
        category: category,
        note: note,
        transactionType: transactionType,
        date: date,
        accountType: accountType,
        userId: userId,
        createdAt: date,
      );

      await docRef.update(transactionModel.toJson());

      return transactionModel;
    } catch (e) {
      throw RemoteException(message: e.toString());
    }
  }
}
