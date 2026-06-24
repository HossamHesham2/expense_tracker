import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failure.dart';
import 'package:expense_tracker/features/auth/data/model/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> login({ required String email, required String password});

  Future<Either<Failure, UserModel>> loginWithGoogle();

  Future<Either<Failure, UserModel>> register({
    required String fullName,
    required String email,
    required String password,
  });
}
