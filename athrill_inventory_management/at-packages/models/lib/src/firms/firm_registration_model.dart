import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class FirmRegistrationModel extends Equatable {
  final String firmName;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String address;
  final String userName;
  final String password;
  final File? imageFile;

  FirmRegistrationModel({
    required this.firmName,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.userName,
    required this.password,
    required this.imageFile,
  });

  @override
  List<Object?> get props => [
        firmName,
        firstName,
        middleName,
        lastName,
        email,
        phoneNumber,
        address,
        userName,
        password,
        imageFile,
      ];

  FirmRegistrationModel copyWith({
    String? firmName,
    String? firstName,
    String? middleName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? address,
    String? userName,
    String? password,
    File? imageFile,
  }) {
    return FirmRegistrationModel(
      firmName: firmName ?? this.firmName,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      imageFile: imageFile ?? this.imageFile,
    );
  }

  Future<Map<String, dynamic>> toMap() async {
    return {
      'firmName': firmName,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'userName': userName,
      'password': password,
      'imageFile': await MultipartFile.fromFile(imageFile!.path),
    };
  }
}
