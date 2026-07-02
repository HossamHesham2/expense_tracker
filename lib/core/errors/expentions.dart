import 'error_model.dart';
//!ServerException
class ServerException implements Exception {
  final ErrorModel errorModel;
  ServerException(this.errorModel);
}
//!CacheExeption
class CacheExeption implements Exception {
  final String errorMessage;
  CacheExeption({required this.errorMessage});
}

