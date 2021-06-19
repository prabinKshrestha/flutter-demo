import 'dart:async';

import 'package:aim_common/common.dart';
import 'package:aim_datas/datas.dart';
import 'package:aim_models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'firm_register_event.dart';
part 'firm_register_state.dart';

class FirmRegisterBloc extends Bloc<FirmRegisterEvent, FirmRegisterState> {
  final FirmContextStore firmContextStore;
  final FirmRepository firmRepository;

  FirmRegisterBloc({
    required this.firmContextStore,
    required this.firmRepository,
  }) : super(FirmRegisterStateInitial());

  @override
  Stream<FirmRegisterState> mapEventToState(FirmRegisterEvent event) async* {
    if (event is FirmRegisterEventRequest) {
      yield FirmRegisterStateLoading();
      try {
        FirmUserModel firmUser = await firmRepository.registerFirm(event.firmRegistrationModel);
        firmContextStore.saveUserContext(firmUser);
        firmContextStore.savePassword(event.firmRegistrationModel.password);
        yield FirmRegisterStateSuccess(firmUserModel: firmUser);
      } on ATBaseException catch (ex) {
        yield FirmRegisterStateError(
          message:
              ex is BusinessException && ex.exception.validations.length > 0 ? ex.exception.validations.map((e) => e.message).join("\n") : ex.message,
        );
      }
    }
  }
}
