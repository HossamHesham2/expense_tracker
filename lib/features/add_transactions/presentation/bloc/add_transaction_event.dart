part of 'add_transaction_bloc.dart';

sealed class AddTransactionEvent extends Equatable {
  const AddTransactionEvent();
}

class SaveTransactionEvent extends AddTransactionEvent {
  final String title;
  final double amount;
  final String category;
  final TransactionType transactionType;
  final AccountType accountType;
  final DateTime date;
  final String? note;

  const SaveTransactionEvent({
    required this.title,
    required this.amount,
    required this.category,
    required this.transactionType,
    required this.accountType,
    required this.date,
    required this.note,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
