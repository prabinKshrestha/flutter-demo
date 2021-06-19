import 'package:aim_common/common.dart';
import 'package:aim_models/models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../base_secure_store.dart';

/// Class to store Firm Context
///
/// Note: Call Dispose when this class is instantiated
class FirmContextStore extends BaseSecureStore {
  final FlutterSecureStorage secureStorage;

  FirmContextStore(this.secureStorage) : super(secureStorage: secureStorage, storageKey: ContextConstant.FIRM_CONTEXT_KEY);

  Future<bool> hasUserContext() async {
    super.storageKey = ContextConstant.FIRM_CONTEXT_KEY;
    return await exist();
  }

  Future<FirmUserModel?> getUserContext() async {
    super.storageKey = ContextConstant.FIRM_CONTEXT_KEY;
    String? rawModel = await get();
    if (rawModel != null) {
      return FirmUserModel.fromJson(rawModel);
    }
    return null;
  }

  Future<void> saveUserContext(FirmUserModel user) async {
    super.storageKey = ContextConstant.FIRM_CONTEXT_KEY;
    return await save(user.toJson());
  }

  Future<void> deleteUserContext() async {
    super.storageKey = ContextConstant.FIRM_CONTEXT_KEY;
    return await delete();
  }

  Future<bool> hasPassword() async {
    super.storageKey = ContextConstant.PASSWORD_CONTEXT_KEY;
    return await exist();
  }

  Future<String?> getPassword() async {
    super.storageKey = ContextConstant.PASSWORD_CONTEXT_KEY;
    return await get();
  }

  Future<void> savePassword(String password) async {
    super.storageKey = ContextConstant.PASSWORD_CONTEXT_KEY;
    return await save(password);
  }

  Future<void> deletePassword() async {
    super.storageKey = ContextConstant.PASSWORD_CONTEXT_KEY;
    return await delete();
  }
}
