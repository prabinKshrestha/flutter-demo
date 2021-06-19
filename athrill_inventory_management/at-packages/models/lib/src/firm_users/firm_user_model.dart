import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../firms/firms_model_barrel.dart';
import 'firm_user_login_model.dart';

class FirmUserModel extends Equatable {
  final int id;
  final int firmUserId;
  final int firmId;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String imageName;
  final String email;
  final String phoneNumber;
  final String address;
  final String image;

  final FirmModel? firm;
  final FirmUserLoginModel? firmUserLogin;

  FirmUserModel({
    required this.id,
    required this.firmUserId,
    required this.firmId,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.imageName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.firm,
    required this.firmUserLogin,
    required this.image,
  });

  factory FirmUserModel.fromMap(Map<String, dynamic> map) {
    return FirmUserModel(
      id: map['Id'],
      firmUserId: map['FirmUserId'],
      firmId: map['FirmId'],
      firstName: map['FirstName'],
      middleName: map['MiddleName'],
      lastName: map['LastName'],
      imageName: map['ImageName'],
      email: map['Email'],
      phoneNumber: map['PhoneNumber'],
      address: map['Address'],
      // image: map['Image'] "",
      image: "",
      firm: map['Firm'] != null ? FirmModel.fromMap(map['Firm']) : null,
      firmUserLogin: map['FirmUserLogin'] != null ? FirmUserLoginModel.fromMap(map['FirmUserLogin']) : null,
    );
  }

  factory FirmUserModel.fromJson(String source) => FirmUserModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'FirmUserId': firmUserId,
      'FirmId': firmId,
      'FirstName': firstName,
      'MiddleName': middleName,
      'LastName': lastName,
      'ImageName': imageName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Address': address,
      'Image': "",
      // 'firm': firm?.toMap(),
      'FirmUserLogin': firmUserLogin?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [
        id,
        firmUserId,
        firmId,
        firstName,
        middleName,
        lastName,
        imageName,
        email,
        phoneNumber,
        address,
        image,
        firm,
        firmUserLogin,
      ];
}
