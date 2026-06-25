import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failure.dart';
import 'package:expense_tracker/features/auth/data/model/user_model.dart';
import 'package:expense_tracker/features/auth/domain/repository/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  final AuthRepo authRepo;

  RegisterUseCase({required this.authRepo});

  Future<Either<Failure, UserModel>> call({
    required String fullName,
    required String email,
    required String password,
  }) {
    return authRepo.register(
      fullName: fullName,
      email: email,
      password: password,
    );
  }
}
