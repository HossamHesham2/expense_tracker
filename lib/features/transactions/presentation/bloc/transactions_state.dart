part of 'transactions_bloc.dart';

class TransactionsState extends Equatable {
  final TransactionsRequest? transactionsRequest;

  final Failure? transactionsFailure;

  final TransactionModel? transactionModel;
  final List<TransactionModel> transactions;

  const TransactionsState({
    required this.transactionsRequest,
    required this.transactionsFailure,
    required this.transactionModel,
    required this.transactions,
  });

  factory TransactionsState.initial() {
    return TransactionsState(
      transactionModel: null,
      transactionsFailure: null,
      transactionsRequest: TransactionsRequest.init,
      transactions: const [],
    );
  }

  TransactionsState copyWith({
    TransactionsRequest? transactionsRequest,
    Failure? transactionsFailure,
    List<TransactionModel>? transactions,
    TransactionModel? transactionModel,
  }) {
    return TransactionsState(
      transactionsRequest: transactionsRequest ?? this.transactionsRequest,
      transactionsFailure: transactionsFailure ?? this.transactionsFailure,
      transactions: transactions ?? this.transactions,
      transactionModel: transactionModel ?? this.transactionModel,
    );
  }

  @override
  List<Object?> get props => [
    transactionsRequest,
    transactionsFailure,
    transactionModel,
    transactions,
  ];
}

enum TransactionsRequest { init, loading, success, error }
