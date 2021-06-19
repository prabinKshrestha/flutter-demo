part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationStateInitial extends AuthenticationState {}

class AuthenticationStateAuthenticated extends AuthenticationState {}

class AuthenticationStateUnAuthenticated extends AuthenticationState {}
