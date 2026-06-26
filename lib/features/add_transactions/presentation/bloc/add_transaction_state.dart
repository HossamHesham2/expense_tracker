part of 'add_transaction_bloc.dart';

class AddTransactionState extends Equatable {
  final AddTransactionRequest? addTransactionRequest;

  final Failure? addTransactionFailure;

  final TransactionModel? transactionModel;

  const AddTransactionState({
    required this.addTransactionRequest,
    required this.addTransactionFailure,
    required this.transactionModel,
  });

  factory AddTransactionState.initial() {
    return const AddTransactionState(
      addTransactionRequest: AddTransactionRequest.init,
      addTransactionFailure: null,
      transactionModel: null,
    );
  }

  AddTransactionState copyWith({
    AddTransactionRequest? addTransactionRequest,
    Failure? addTransactionFailure,
    TransactionModel? transactionModel,
  }) {
    return AddTransactionState(
      addTransactionRequest:
          addTransactionRequest ?? this.addTransactionRequest,
      addTransactionFailure:
          addTransactionFailure ?? this.addTransactionFailure,
      transactionModel: transactionModel ?? this.transactionModel,
    );
  }

  @override
  List<Object?> get props => [
    addTransactionRequest,
    addTransactionFailure,
    transactionModel,
  ];
}

enum AddTransactionRequest { init, loading, success, error }
