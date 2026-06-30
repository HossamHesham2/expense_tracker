import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failure.dart';
import 'package:expense_tracker/features/auth/domain/repository/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  final AuthRepo authRepo;

  LogoutUseCase({required this.authRepo});

  Future<Either<Failure,bool>> call() {
    return authRepo.logout();
  }
}
