import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../firm_user_model.dart';

class AuthResponseModel extends Equatable {
  final String token;
  final bool? isResetPassword;
  final FirmUserModel user;

  AuthResponseModel({
    required this.token,
    this.isResetPassword,
    required this.user,
  });

  factory AuthResponseModel.fromMap(Map<String, dynamic> map) {
    return AuthResponseModel(
      token: map['Token'],
      isResetPassword: map['IsResetPassword'],
      user: FirmUserModel.fromMap(map['User']),
    );
  }

  @override
  List<Object?> get props => [token, isResetPassword, user];
}
