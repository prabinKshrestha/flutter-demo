import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Abstract Class for secure store
abstract class BaseSecureStore {
  final FlutterSecureStorage secureStorage;
  String storageKey;

  BaseSecureStore({
    required this.secureStorage,
    required this.storageKey,
  });

  Future<String?> get() async {
    return await secureStorage.read(key: storageKey);
  }

  Future<bool> exist() async {
    String? value = await secureStorage.read(key: storageKey);
    return value != null && value.isNotEmpty;
  }

  Future<void> save(String value) async {
    await secureStorage.write(key: storageKey, value: value);
    return;
  }

  Future<void> delete() async {
    await secureStorage.delete(key: storageKey);
    return;
  }
}
