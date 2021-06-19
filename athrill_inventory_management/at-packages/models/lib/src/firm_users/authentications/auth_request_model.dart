import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthRequestModel extends Equatable {
  final String username;
  final String password;

  AuthRequestModel({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [username, password];

  AuthRequestModel copyWith({
    String? username,
    String? password,
    int? firmId,
  }) {
    return AuthRequestModel(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
