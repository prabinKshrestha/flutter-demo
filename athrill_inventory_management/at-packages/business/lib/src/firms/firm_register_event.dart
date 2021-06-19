part of 'firm_register_bloc.dart';

@immutable
abstract class FirmRegisterEvent {}

class FirmRegisterEventInitial extends FirmRegisterEvent {}

class FirmRegisterEventRequest extends FirmRegisterEvent {
  final FirmRegistrationModel firmRegistrationModel;

  FirmRegisterEventRequest({
    required this.firmRegistrationModel,
  });
}
