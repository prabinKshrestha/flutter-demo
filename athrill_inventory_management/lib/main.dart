import 'package:aim_datas/datas.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'app.dart';

void main() {
  final Dio _httpClient = Dio();
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final FirmContextStore firmContextStore = FirmContextStore(_storage);
  final UserContextStore userContextStore = UserContextStore(_storage);

  // todo : have common provider pass values
  runApp(App(
    firmContextStore: firmContextStore,
    userContextStore: userContextStore,
    firmAuthenticationRepository: FirmAuthenticationRepository(
      firmAuthenticationApiProvider: FirmAuthenticationAPIProvider(
        httpClient: _httpClient,
        storage: _storage,
        userContextStore: userContextStore,
      ),
    ),
    transactionRepository: TransactionRepository(
      transactionAPIProvider: TransactionAPIProvider(
        httpClient: _httpClient,
        storage: _storage,
        userContextStore: userContextStore,
      ),
    ),
    cardRepository: CardRepository(
      cardAPIProvider: CardAPIProvider(
        httpClient: _httpClient,
        storage: _storage,
        userContextStore: userContextStore,
      ),
    ),
    firmRepository: FirmRepository(
      firmAPIProvider: FirmAPIProvider(
        httpClient: _httpClient,
        storage: _storage,
        userContextStore: userContextStore,
      ),
    ),
  ));
}
