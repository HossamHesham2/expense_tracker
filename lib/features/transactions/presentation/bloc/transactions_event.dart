part of 'transactions_bloc.dart';

sealed class TransactionsEvent extends Equatable {
  const TransactionsEvent();
}

class GetAllTransactionsEvent extends TransactionsEvent {
  const GetAllTransactionsEvent();

  @override
  List<Object?> get props => [];
}

class EditTransactionEvent extends TransactionsEvent {
  final String id;
  final String title;
  final double amount;
  final String category;
  final TransactionType transactionType;
  final AccountType accountType;
  final DateTime date;
  final String? note;

  const EditTransactionEvent({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.transactionType,
    required this.accountType,
    required this.date,
    this.note,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    amount,
    category,
    transactionType,
    accountType,
    date,
    note,
  ];
}

class DeleteTransactionEvent extends TransactionsEvent {
  final String id;

  const DeleteTransactionEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
