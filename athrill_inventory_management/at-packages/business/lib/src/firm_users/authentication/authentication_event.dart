part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthenticationEventStart extends AuthenticationEvent {}

class AuthenticationEventSignIn extends AuthenticationEvent {}

class AuthenticationEventSignOut extends AuthenticationEvent {}
