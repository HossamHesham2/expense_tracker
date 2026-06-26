import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:expense_tracker/core/errors/app_exceptions.dart';
import 'package:expense_tracker/core/models/transaction_model.dart';
import 'package:expense_tracker/features/add_transactions/data/request/add_transaction_remote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddTransactionRemote)
class AddTransactionRemoteImpl extends AddTransactionRemote {
  final FirebaseAuth firebaseAuth;

  final FirebaseFirestore firebaseFirestore;

  AddTransactionRemoteImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  @override
  Future<TransactionModel> addTransaction({
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
          .collection('users')
          .doc(userId)
          .collection('transactions')
          .doc();
      final transactionModel = TransactionModel(
        id: docRef.id,
        title: title,
        amount: amount,
        category: category,
        note: note,
        transactionType: transactionType,
        date: date,
        accountType: accountType,
        userId: userId,
      );

      await docRef.set(transactionModel.toJson());
      return transactionModel;
    } catch (e) {
      throw RemoteException(message: e.toString());
    }
  }
}
