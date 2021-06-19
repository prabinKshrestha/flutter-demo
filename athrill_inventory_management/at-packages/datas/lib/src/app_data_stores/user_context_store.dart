import 'package:aim_common/common.dart';
import 'package:aim_models/models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';

import '../base_secure_store.dart';

/// Class to store token and user context
///
/// Note: Call Dispose when this class is instantiated
class UserContextStore extends BaseSecureStore {
  final FlutterSecureStorage secureStorage;
  final PublishSubject<bool> deleteContextSubject = new PublishSubject<bool>();

  UserContextStore(this.secureStorage) : super(secureStorage: secureStorage, storageKey: ContextConstant.TOKEN_CONTEXT_KEY);

  Future<void> saveAllContext(AuthResponseModel authResponseModel) async {
    await saveToken(authResponseModel.token);
    await saveUserContext(authResponseModel.user);
    return;
  }

  Future<void> deleteAllContext() async {
    await deleteToken();
    await deleteUserContext();
    this.deleteContextSubject.add(true);
    return;
  }

  Future<bool> hasToken() async {
    super.storageKey = ContextConstant.TOKEN_CONTEXT_KEY;
    return await exist();
  }

  Future<String?> getToken() async {
    super.storageKey = ContextConstant.TOKEN_CONTEXT_KEY;
    return await get();
  }

  Future<void> saveToken(String token) async {
    super.storageKey = ContextConstant.TOKEN_CONTEXT_KEY;
    return await save(token);
  }

  Future<void> deleteToken() async {
    super.storageKey = ContextConstant.TOKEN_CONTEXT_KEY;
    return await delete();
  }

  Future<bool> hasUserContext() async {
    super.storageKey = ContextConstant.USER_CONTEXT_KEY;
    return await exist();
  }

  Future<FirmUserModel?> getUserContext() async {
    super.storageKey = ContextConstant.TOKEN_CONTEXT_KEY;
    String? rawModel = await get();
    if (rawModel != null) {
      return FirmUserModel.fromJson(rawModel);
    }
    return null;
  }

  Future<void> saveUserContext(FirmUserModel user) async {
    super.storageKey = ContextConstant.USER_CONTEXT_KEY;
    return await save(user.toJson());
  }

  Future<void> deleteUserContext() async {
    super.storageKey = ContextConstant.USER_CONTEXT_KEY;
    return await delete();
  }

  void dispose() {
    deleteContextSubject.close();
  }
}
