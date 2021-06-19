import 'dart:async';

import 'package:aim_datas/datas.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

/// Bloc used for authentication
///
/// NOTE: This is not network based BLOC. Only used in application layer for raise and listen event related to authentication.
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserContextStore userContextStore;

  AuthenticationBloc({required this.userContextStore}) : super(AuthenticationStateInitial()) {
    userContextStore.deleteContextSubject.stream.listen((isDeleted) {
      if (isDeleted) {
        add(AuthenticationEventSignOut());
        userContextStore.deleteContextSubject.add(false);
      }
    });
  }

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AuthenticationEventStart) {
      // NOTE: This event is raised at app start. Business is to always ask for authentication after app start so we are deleting it manually
      await userContextStore.deleteAllContext();
      yield AuthenticationStateUnAuthenticated();
      // if (await userContextStore.hasToken()) {
      //   yield AuthenticationStateAuthenticated();
      // } else {
      //   yield AuthenticationStateUnAuthenticated();
      // }
    }
    if (event is AuthenticationEventSignIn) {
      yield AuthenticationStateAuthenticated();
    }
    if (event is AuthenticationEventSignOut) {
      if (await userContextStore.hasToken()) {
        await userContextStore.deleteAllContext();
      }
      yield AuthenticationStateUnAuthenticated();
    }
  }

  @override
  Future<void> close() async {
    userContextStore.dispose();
    await super.close();
  }
}
