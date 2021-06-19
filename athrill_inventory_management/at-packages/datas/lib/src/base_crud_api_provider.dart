import 'package:aim_models/models.dart';

import 'base_api_provider.dart';

abstract class BaseCrudAPIProivder extends BaseAPIProvider {
  abstract String baseUrl;

  BaseCrudAPIProivder({
    required httpClient,
    required storage,
    required userContextStore,
  }) : super(httpClient: httpClient, storage: storage, userContextStore: userContextStore);

  Future<List> getItems({ODataParametersModel? odataParams, Map<String, dynamic>? queryParams}) async {
    return await getAction<List>(baseUrl, odataParams: odataParams, queryParams: queryParams);
  }

  Future<dynamic> addItem(Map<String, dynamic> data, {ODataParametersModel? odataParams, Map<String, dynamic>? queryParams}) async {
    return await postAction<dynamic>(baseUrl, data, odataParams: odataParams, queryParams: queryParams, isFormData: isFormData);
  }

  Future<dynamic> updateItem(int id, Map<String, dynamic> data, {ODataParametersModel? odataParams, Map<String, dynamic>? queryParams}) async {
    return await putAction<dynamic>('$baseUrl/$id', data, odataParams: odataParams, queryParams: queryParams, isFormData: isFormData);
  }

  Future<void> deleteItem(int id) async {
    return await deleteAction('$baseUrl/$id');
  }

  bool get isFormData => false;
}
