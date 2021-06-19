part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  List<Object> get props => [];
}

class LoginEventPasswordObscured extends LoginEvent {
  final bool isObscured;

  LoginEventPasswordObscured({
    required this.isObscured,
  });
}

class LoginEventRequestWithLocalAuth extends LoginEvent {}

class LoginEventRequest extends LoginEvent {
  final String username;
  final String password;

  LoginEventRequest(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}
