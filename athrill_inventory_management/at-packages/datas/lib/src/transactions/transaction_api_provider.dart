part of 'transaction_repository.dart';

class TransactionAPIProvider extends BaseCrudAPIProivder {
  TransactionAPIProvider({
    required httpClient,
    required storage,
    required userContextStore,
  }) : super(httpClient: httpClient, storage: storage, userContextStore: userContextStore);

  @override
  String baseUrl = "transaction";
}
