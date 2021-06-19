import 'dart:async';

import 'package:aim_common/common.dart';
import 'package:aim_datas/datas.dart';
import 'package:aim_models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../firm_users_business_barrel.dart';

part 'login_event.dart';
part 'login_state.dart';

/// Bloc is used for Login purpose
///
/// Bloc also uses Network call
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirmContextStore firmContextStore;
  final AuthenticationBloc authenticationBloc;
  final FirmAuthenticationRepository firmAuthenticationRepository;

  LoginBloc({
    required this.firmContextStore,
    required this.authenticationBloc,
    required this.firmAuthenticationRepository,
  }) : super(LoginStateInitial(isPasswordHidden: true));

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEventPasswordObscured) {
      yield LoginStateInitial(isPasswordHidden: event.isObscured);
    }

    if (event is LoginEventRequest || event is LoginEventRequestWithLocalAuth) {
      yield LoginStateLoading();
      String username = "";
      String password = "";
      if (event is LoginEventRequest) {
        username = event.username;
        password = event.password;
      } else {
        // todo : check if user context for firm exist and throw error if does not exist.
        FirmUserModel? storedFirmUser = await firmContextStore.getUserContext();
        username = storedFirmUser?.firmUserLogin?.username ?? "";
        password = (await firmContextStore.getPassword())!;
      }
      if (_isValidRequest(username, password)) {
        try {
          AuthResponseModel response = await firmAuthenticationRepository.signIn(
            AuthRequestModel(
              username: username,
              password: password,
            ),
          );
          await authenticationBloc.userContextStore.saveAllContext(response);
          await firmContextStore.saveUserContext(response.user);
          await firmContextStore.savePassword(password);
          authenticationBloc.add(AuthenticationEventSignIn());
          yield LoginStateSuccess();
        } on ATBaseException catch (ex) {
          authenticationBloc.add(AuthenticationEventSignOut());
          yield LoginStateFailure(
            errorMessage: ex is BusinessException && ex.exception.validations.length > 0
                ? ex.exception.validations.map((e) => e.message).join("\n")
                : ex.message,
          );
        }
      } else {
        String message = "";
        if (username.isEmpty) {
          message += "Username is required.";
        } else if (username.length < 6) {
          message += "Username is must be more than 6 characters.";
        }
        if (password.isEmpty) {
          message += (message.isEmpty ? "" : "\n") + "Password is required.";
        }
        authenticationBloc.add(AuthenticationEventSignOut());
        yield LoginStateFailure(errorMessage: message);
      }
    }
  }

  bool _isValidRequest(String username, String password) {
    return username.isNotEmpty && username.length >= 6 && password.isNotEmpty;
  }
}
