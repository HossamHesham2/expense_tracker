
import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/app_exceptions.dart';
import 'package:expense_tracker/core/errors/failure.dart';
import 'package:expense_tracker/features/auth/data/model/user_model.dart';
import 'package:expense_tracker/features/auth/data/request/remote/auth_remote.dart';
import 'package:expense_tracker/features/auth/domain/repository/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  final AuthRemote authRemote;

  AuthRepoImpl({required this.authRemote});

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await authRemote.login(email: email, password: password);
      return Right(result);
    } on RemoteException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> loginWithGoogle() async {
    try {
      final result = await authRemote.loginWithGoogle();
      return Right(result);
    } on RemoteException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final result = await authRemote.register(
        fullName: fullName,
        email: email,
        password: password,
      );
      return Right(result);
    } on RemoteException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
