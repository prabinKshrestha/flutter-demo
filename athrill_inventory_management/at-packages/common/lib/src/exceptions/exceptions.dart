import 'exception_model.dart';

class ATBaseException implements Exception {
  final String message;
  ATBaseException({
    required this.message,
  });
}

class BusinessException extends ATBaseException {
  final BusinessExceptionModel exception;
  BusinessException({
    required this.exception,
  }) : super(message: exception.message);
}

class AuthenticationException extends ATBaseException {
  final String message;
  AuthenticationException({
    required this.message,
  }) : super(message: message);
}

class UnknownException extends ATBaseException {
  final String message;
  UnknownException({
    required this.message,
  }) : super(message: message);
}
