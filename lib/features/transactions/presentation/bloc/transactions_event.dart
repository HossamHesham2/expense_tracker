part of 'transactions_bloc.dart';

sealed class TransactionsEvent extends Equatable {
  const TransactionsEvent();
}
 class GetAllTransactionsEvent extends TransactionsEvent {

  const GetAllTransactionsEvent();

  @override
  List<Object?> get props => [];
}
