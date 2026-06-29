import 'package:expense_tracker/features/auth/data/model/user_model.dart';

abstract class AuthRemote {
  Future<UserModel> login({required String email, required String password});

  Future<UserModel> register({required String fullName,required String email,required String password});

  Future<UserModel> loginWithGoogle();
  Future<bool> logout();
}
