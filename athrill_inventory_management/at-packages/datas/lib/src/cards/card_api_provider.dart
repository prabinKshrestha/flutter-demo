part of 'card_repository.dart';

class CardAPIProvider extends BaseCrudAPIProivder {
  CardAPIProvider({
    required httpClient,
    required storage,
    required userContextStore,
  }) : super(httpClient: httpClient, storage: storage, userContextStore: userContextStore);

  @override
  String baseUrl = "card";

  @override
  bool get isFormData => true;
}
