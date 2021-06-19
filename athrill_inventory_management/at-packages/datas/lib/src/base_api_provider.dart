import 'package:aim_common/common.dart';
import 'package:aim_models/models.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as storageLibrary;

import 'app_data_stores/app_data_stores_datas_barrel.dart';

/// Abstract Class for Data Provider : API Calls
abstract class BaseAPIProvider {
  final Dio httpClient;
  final storageLibrary.FlutterSecureStorage storage;
  final UserContextStore userContextStore;

  BaseAPIProvider({
    required this.httpClient,
    required this.storage,
    required this.userContextStore,
  }) {
    httpClient.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers.addAll(await _buildHeaders());
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          return handler.next(e);
        },
      ),
    );
  }

  /// Method to perform GET Action
  ///
  /// It returns the decoded object. So, not need to be decoded again.
  ///
  /// [path] The path after host name.
  ///
  /// [odataParams] The OData Parameters for server side processing.
  ///
  /// [queryParams] Custom Query Parameters.
  Future<T> getAction<T>(String path, {ODataParametersModel? odataParams, Map<String, dynamic>? queryParams}) async {
    return await _apiErrorHandler<T>(() async {
      final Response response = await this.httpClient.get<T>(
            _buildURI(path),
            queryParameters: _buildQueryParameters(odataParams, queryParams),
          );
      return response.data!;
    });
  }

  /// Method to perform POST Action
  ///
  /// It returns the decoded object. So, not need to be decoded again.
  ///
  /// [path] The path after host name.
  ///
  /// [body] The request body in format Map<String, dynamic>
  ///
  ///  Set [isFormData] true if request body is FormData. Default value is false.
  ///
  /// [odataParams] The OData Parameters for server side processing.
  ///
  /// [queryParams] Custom Query Parameters.
  Future<T> postAction<T>(
    String path,
    Map<String, dynamic> body, {
    bool isFormData = false,
    ODataParametersModel? odataParams,
    Map<String, dynamic>? queryParams,
  }) async {
    return await _apiErrorHandler<T>(() async {
      final Response response = await this.httpClient.post<T>(
            _buildURI(path),
            data: isFormData ? FormData.fromMap(body) : body,
            queryParameters: _buildQueryParameters(odataParams, queryParams),
          );
      return response.data!;
    });
  }

  /// Method to perform PUT Action
  ///
  /// It returns the decoded object. So, not need to be decoded again.
  ///
  /// [path] The path after host name.
  ///
  /// [body] The request body in format Map<String, dynamic>
  ///
  ///  Set [isFormData] true if request body is FormData. Default value is false.
  ///
  /// [odataParams] The OData Parameters for server side processing.
  ///
  /// [queryParams] Custom Query Parameters.
  Future<T> putAction<T>(
    String path,
    Map<String, dynamic> body, {
    bool isFormData = false,
    ODataParametersModel? odataParams,
    Map<String, dynamic>? queryParams,
  }) async {
    return await _apiErrorHandler<T>(() async {
      final Response response = await this.httpClient.put<T>(
            _buildURI(path),
            data: isFormData ? FormData.fromMap(body) : body,
            queryParameters: _buildQueryParameters(odataParams, queryParams),
          );
      return response.data!;
    });
  }

  /// Method to perform DELETE Action
  ///
  /// [path] The path after host name.
  Future<void> deleteAction(String path) async {
    return await _apiErrorHandler(() async => await this.httpClient.delete(_buildURI(path)));
  }

  String _buildURI(String path) {
    return "${AppConstant.BASE_URL_SCHEME}://${AppConstant.BASE_URL}/$path";
  }

  Future<Map<String, dynamic>> _buildHeaders() async {
    String? token = await userContextStore.getToken();
    return {"x-app-context": "aim-mobile", "authorization": "Bearer $token"};
  }

  Map<String, dynamic>? _buildQueryParameters(ODataParametersModel? odataParams, Map<String, dynamic>? queryParameters) {
    Map<String, dynamic> retVal = {};
    if (odataParams != null) {
      retVal.addAll(odataParams.getJSONObjectForAPICall());
    }
    if (queryParameters != null) {
      retVal.addAll(queryParameters);
    }
    if (retVal.isEmpty) {
      return null;
    }
    return retVal;
  }

  void _handleError(Response? response) {
    switch (response?.statusCode) {
      case 400:
        BusinessExceptionModel validationExceptions = BusinessExceptionModel.fromMap(response?.data);
        throw BusinessException(exception: validationExceptions);
      case 401:
        userContextStore.deleteAllContext();
        throw AuthenticationException(message: "You are not Unauthorized.");
      case 500:
        throw UnknownException(message: "Internal Server Error. Please contact administrator if error persist.");
      default:
        throw UnknownException(message: "Unknown Error.");
    }
  }

  Future<T> _apiErrorHandler<T>(Function function) async {
    try {
      return await function();
    } on DioError catch (e) {
      _handleError(e.response);
      return Future.value();
    }
  }
}
