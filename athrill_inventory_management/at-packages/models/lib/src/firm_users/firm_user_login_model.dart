import 'package:equatable/equatable.dart';

import '../firms/firms_model_barrel.dart';
import 'firm_user_model.dart';

class FirmUserLoginModel extends Equatable {
  final int id;
  final int firmUserLoginId;
  final int firmId;
  final int firmUserId;
  final String username;
  final bool? isResetPassword;

  final FirmModel? firm;
  final FirmUserModel? firmUser;

  FirmUserLoginModel({
    required this.id,
    required this.firmUserLoginId,
    required this.firmId,
    required this.firmUserId,
    required this.username,
    this.isResetPassword,
    this.firm,
    this.firmUser,
  });

  factory FirmUserLoginModel.fromMap(Map<String, dynamic> map) {
    return FirmUserLoginModel(
      id: map['Id'],
      firmUserLoginId: map['FirmUserLoginId'],
      firmId: map['FirmId'],
      firmUserId: map['FirmUserId'],
      username: map['Username'],
      isResetPassword: map['IsResetPassword'],
      // firm: FirmModel.fromMap(map['Firm']),
      // firmUser: FirmUserModel.fromMap(map['FirmUser']),
    );
  }

  @override
  List<Object?> get props => [id, firmUserLoginId, firmId, firmUserId, username, isResetPassword, firm, firmUser];

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'FirmUserLoginId': firmUserLoginId,
      'FirmId': firmId,
      'FirmUserId': firmUserId,
      'Username': username,
      'IsResetPassword': isResetPassword,
      // 'firm': firm?.toMap(),
      // 'firmUser': firmUser?.toMap(),
    };
  }
}
