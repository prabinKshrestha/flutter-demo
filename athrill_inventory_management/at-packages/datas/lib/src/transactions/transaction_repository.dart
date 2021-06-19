import 'package:aim_models/models.dart';

import '../base_crud_api_provider.dart';

part 'transaction_api_provider.dart';

class TransactionRepository {
  final TransactionAPIProvider transactionAPIProvider;

  TransactionRepository({
    required this.transactionAPIProvider,
  });

  Future<List<TransactionModel>> getTransactions({ODataParametersModel? odataParams, Map<String, dynamic>? queryParams}) async {
    return (await transactionAPIProvider.getItems(odataParams: odataParams, queryParams: queryParams))
        .map((e) => TransactionModel.fromMap(e))
        .toList();
  }

  Future<TransactionModel> addTransaction(
    TransactionModifyModel transactionModifyModel, {
    ODataParametersModel? odataParams,
    Map<String, dynamic>? queryParams,
  }) async {
    return TransactionModel.fromMap(
      await transactionAPIProvider.addItem(transactionModifyModel.toMap(), odataParams: odataParams, queryParams: queryParams),
    );
  }

  Future<TransactionModel> updateTransaction(
    TransactionModifyModel transactionModifyModel, {
    ODataParametersModel? odataParams,
    Map<String, dynamic>? queryParams,
  }) async {
    return TransactionModel.fromMap(await transactionAPIProvider.updateItem(
      transactionModifyModel.transactionId,
      transactionModifyModel.toMap(),
      odataParams: odataParams,
      queryParams: queryParams,
    ));
  }

  Future<void> deleteTransaction(int id) async {
    await transactionAPIProvider.deleteItem(id);
  }
}
