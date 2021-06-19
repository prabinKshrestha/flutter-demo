part of 'firm_authentication_repository.dart';

class FirmAuthenticationAPIProvider extends BaseAPIProvider {
  FirmAuthenticationAPIProvider({
    required httpClient,
    required storage,
    required userContextStore,
  }) : super(httpClient: httpClient, storage: storage, userContextStore: userContextStore);

  Future<dynamic> signIn(Map<String, dynamic> data) async {
    return await postAction('firmusers/authentication/login', data);
  }
}
