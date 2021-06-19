import 'dart:io';
import 'package:dio/dio.dart';

import 'package:equatable/equatable.dart';

class CardModifyModel extends Equatable {
  final int cardId;
  final String accountNumber;
  final String cardHolderName;
  final String organizationName;
  final int fromMonth;
  final int fromYear;
  final int toMonth;
  final int toYear;
  final File? imageFile;
  final bool isImageChanged;

  final String? networkImage; // not used for api request
  final String? networkImageName; // not used for api request

  get isAdd {
    return cardId == 0;
  }

  CardModifyModel({
    required this.cardId,
    required this.accountNumber,
    required this.cardHolderName,
    required this.organizationName,
    required this.fromMonth,
    required this.fromYear,
    required this.toMonth,
    required this.toYear,
    this.imageFile,
    this.isImageChanged = false,
    this.networkImage,
    this.networkImageName,
  });

  @override
  List<Object?> get props => [
        cardId,
        accountNumber,
        cardHolderName,
        organizationName,
        fromMonth,
        fromYear,
        toMonth,
        toYear,
        imageFile,
        isImageChanged,
      ];

  CardModifyModel copyWith({
    int? cardId,
    String? accountNumber,
    String? cardHolderName,
    String? organizationName,
    int? fromMonth,
    int? fromYear,
    int? toMonth,
    int? toYear,
    File? imageFile,
    bool? isImageChanged,
  }) {
    return CardModifyModel(
      cardId: cardId ?? this.cardId,
      accountNumber: accountNumber ?? this.accountNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      organizationName: organizationName ?? this.organizationName,
      fromMonth: fromMonth ?? this.fromMonth,
      fromYear: fromYear ?? this.fromYear,
      toMonth: toMonth ?? this.toMonth,
      toYear: toYear ?? this.toYear,
      imageFile: imageFile ?? this.imageFile,
      isImageChanged: isImageChanged ?? this.isImageChanged,
    );
  }

  Future<Map<String, dynamic>> toMap() async {
    return {
      'cardId': cardId,
      'accountNumber': accountNumber,
      'cardHolderName': cardHolderName,
      'organizationName': organizationName,
      'fromMonth': fromMonth,
      'fromYear': fromYear,
      'toMonth': toMonth,
      'toYear': toYear,
      'imageFile': imageFile != null ? await MultipartFile.fromFile(imageFile!.path) : null,
      'isImageChanged': isImageChanged,
    };
  }
}
