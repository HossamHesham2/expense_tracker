class AppExceptions implements Exception{
  final String message ;

  AppExceptions({required this.message});
}
class RemoteException extends AppExceptions{
  RemoteException({required super.message});
}
class LocalException extends AppExceptions{
  LocalException({required super.message});
}