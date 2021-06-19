import 'package:aim_models/models.dart';
import '../base_crud_api_provider.dart';

part 'firm_api_provider.dart';

class FirmRepository {
  final FirmAPIProvider firmAPIProvider;

  FirmRepository({
    required this.firmAPIProvider,
  });

  Future<FirmUserModel> registerFirm(FirmRegistrationModel model, {ODataParametersModel? odataParams, Map<String, dynamic>? queryParams}) async {
    return FirmUserModel.fromMap(await firmAPIProvider.registerFirm(await model.toMap(), odataParams: odataParams, queryParams: queryParams));
  }
}
