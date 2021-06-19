part of 'firm_register_bloc.dart';

@immutable
abstract class FirmRegisterState {}

class FirmRegisterStateInitial extends FirmRegisterState {}

class FirmRegisterStateLoading extends FirmRegisterState {}

class FirmRegisterStateSuccess extends FirmRegisterState {
  final FirmUserModel firmUserModel;

  FirmRegisterStateSuccess({
    required this.firmUserModel,
  });
}

class FirmRegisterStateError extends FirmRegisterState {
  final String message;

  FirmRegisterStateError({
    required this.message,
  });
}
