import 'package:aim_models/models.dart';

import '../../base_api_provider.dart';

part 'firm_authentication_api_provider.dart';

class FirmAuthenticationRepository {
  final FirmAuthenticationAPIProvider firmAuthenticationApiProvider;

  FirmAuthenticationRepository({
    required this.firmAuthenticationApiProvider,
  });

  Future<AuthResponseModel> signIn(AuthRequestModel data) async {
    return AuthResponseModel.fromMap(await firmAuthenticationApiProvider.signIn(data.toMap()));
  }
}
