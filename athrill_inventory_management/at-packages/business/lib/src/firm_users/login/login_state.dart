part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginStateInitial extends LoginState {
  final bool isPasswordHidden;

  LoginStateInitial({
    required this.isPasswordHidden,
  });
}

class LoginStateLoading extends LoginState {}

class LoginStateSuccess extends LoginState {}

class LoginStateFailure extends LoginState {
  final String errorMessage;

  LoginStateFailure({
    required this.errorMessage,
  });
}
