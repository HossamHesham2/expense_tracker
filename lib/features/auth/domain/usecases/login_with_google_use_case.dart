import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failure.dart';
import 'package:expense_tracker/features/auth/data/model/user_model.dart';
import 'package:expense_tracker/features/auth/domain/repository/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginWithGoogleUseCase {
  final AuthRepo authRepo;

  LoginWithGoogleUseCase({required this.authRepo});

  Future<Either<Failure, UserModel>> call() {
    return authRepo.loginWithGoogle();
  }
}
