import 'package:aim_models/models.dart';
import '../base_crud_api_provider.dart';

part 'card_api_provider.dart';

class CardRepository {
  final CardAPIProvider cardAPIProvider;

  CardRepository({
    required this.cardAPIProvider,
  });

  Future<List<CardModel>> getCards({ODataParametersModel? odataParams, Map<String, dynamic>? queryParams}) async {
    return (await cardAPIProvider.getItems(odataParams: odataParams, queryParams: queryParams)).map((e) => CardModel.fromMap(e)).toList();
  }

  Future<CardModel> addCard(CardModifyModel cardModifyModel, {ODataParametersModel? odataParams, Map<String, dynamic>? queryParams}) async {
    return CardModel.fromMap(await cardAPIProvider.addItem(await cardModifyModel.toMap(), odataParams: odataParams, queryParams: queryParams));
  }

  Future<CardModel> updateCard(CardModifyModel cardModifyModel, {ODataParametersModel? odataParams, Map<String, dynamic>? queryParams}) async {
    return CardModel.fromMap(
      await cardAPIProvider.updateItem(cardModifyModel.cardId, await cardModifyModel.toMap(), odataParams: odataParams, queryParams: queryParams),
    );
  }

  Future<void> deleteCard(int id) async {
    await cardAPIProvider.deleteItem(id);
  }
}
