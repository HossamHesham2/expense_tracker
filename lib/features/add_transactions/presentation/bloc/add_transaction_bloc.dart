import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/core/errors/failure.dart';
import 'package:expense_tracker/core/models/transaction_model.dart';
import 'package:expense_tracker/features/add_transactions/domain/usecases/add_transaction_use_case.dart';
import 'package:injectable/injectable.dart';

part 'add_transaction_event.dart';

part 'add_transaction_state.dart';

@injectable
class AddTransactionBloc
    extends Bloc<AddTransactionEvent, AddTransactionState> {
  final AddTransactionUseCase addTransactionUseCase;

  AddTransactionBloc({required this.addTransactionUseCase})
    : super(AddTransactionState.initial()) {
    on<AddTransactionEvent>((event, emit) async {
      switch (event) {
        case SaveTransactionEvent():
          emit(
            state.copyWith(
              addTransactionRequest: AddTransactionRequest.loading,
            ),
          );
          final result = await addTransactionUseCase.call(
            title: event.title,
            amount: event.amount,
            category: event.category,
            transactionType: event.transactionType,
            accountType: event.accountType,
            date: event.date,
            note: event.note,
          );

          result.fold(
            (l) => emit(
              state.copyWith(
                addTransactionRequest: AddTransactionRequest.error,
                addTransactionFailure: ServerFailure(errMessage: l.errMessage),
              ),
            ),
            (r) => emit(
              state.copyWith(
                addTransactionRequest: AddTransactionRequest.success,
                transactionModel: r,
              ),
            ),
          );
      }
    });
  }
}
