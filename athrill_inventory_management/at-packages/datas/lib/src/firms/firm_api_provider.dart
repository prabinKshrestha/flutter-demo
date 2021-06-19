part of 'firm_repository.dart';

class FirmAPIProvider extends BaseCrudAPIProivder {
  FirmAPIProvider({
    required httpClient,
    required storage,
    required userContextStore,
  }) : super(httpClient: httpClient, storage: storage, userContextStore: userContextStore);

  Future<dynamic> registerFirm(Map<String, dynamic> data, {ODataParametersModel? odataParams, Map<String, dynamic>? queryParams}) async {
    return await postAction<dynamic>("$baseUrl/register", data, odataParams: odataParams, queryParams: queryParams, isFormData: true);
  }

  @override
  String baseUrl = "firms";

  @override
  bool get isFormData => true;
}
