part of 'transactions_bloc.dart';

class TransactionsState extends Equatable {
  final TransactionsRequest? transactionsRequest;
  final TransactionsRequest? editTransactionsRequest;

  final Failure? transactionsFailure;
  final Failure? editTransactionsFailure;

  final TransactionModel? transactionModel;
  final List<TransactionModel> transactions;

  const TransactionsState({
    required this.transactionsRequest,
    required this.editTransactionsRequest,
    required this.transactionsFailure,
    required this.editTransactionsFailure,
    required this.transactionModel,
    required this.transactions,
  });

  factory TransactionsState.initial() {
    return TransactionsState(
      transactionModel: null,
      transactionsFailure: null,
      transactionsRequest: TransactionsRequest.init,
      transactions: const [],
      editTransactionsFailure: null,
      editTransactionsRequest: TransactionsRequest.init,
    );
  }

  TransactionsState copyWith({
    TransactionsRequest? transactionsRequest,
    Failure? transactionsFailure,
    List<TransactionModel>? transactions,
    TransactionModel? transactionModel,
    TransactionsRequest? editTransactionsRequest,
    Failure? editTransactionsFailure,
  }) {
    return TransactionsState(
      transactionsRequest: transactionsRequest ?? this.transactionsRequest,
      editTransactionsRequest:
          editTransactionsRequest ?? this.editTransactionsRequest,
      transactionsFailure: transactionsFailure ?? this.transactionsFailure,
      editTransactionsFailure:
          editTransactionsFailure ?? this.editTransactionsFailure,
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
    editTransactionsRequest,
    editTransactionsFailure,
  ];
}

enum TransactionsRequest { init, loading, success, error }
