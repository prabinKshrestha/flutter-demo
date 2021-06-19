import 'dart:convert';

import 'package:equatable/equatable.dart';

class CardModel extends Equatable {
  final int id;
  final int cardId;
  final int firmId;
  final String cardCode;
  final String? imageName;
  final String accountNumber;
  final int fromMonth;
  final int fromYear;
  final int toMonth;
  final int toYear;
  final String cardHolderName;
  final String organizationName;
  final String image;
  final String qrCodeImage;
  final DateTime createdOn;
  final DateTime? updatedOn;
  final int createdById;
  final int updatedById;

  CardModel({
    required this.id,
    required this.cardId,
    required this.firmId,
    required this.cardCode,
    this.imageName,
    required this.accountNumber,
    required this.fromMonth,
    required this.fromYear,
    required this.toMonth,
    required this.toYear,
    required this.cardHolderName,
    required this.organizationName,
    required this.image,
    required this.qrCodeImage,
    required this.createdOn,
    this.updatedOn,
    required this.createdById,
    required this.updatedById,
  });

  @override
  List<Object?> get props => [
        id,
        cardId,
        firmId,
        cardCode,
        imageName,
        accountNumber,
        fromMonth,
        fromYear,
        toMonth,
        toYear,
        cardHolderName,
        organizationName,
        image,
        qrCodeImage,
        createdOn,
        updatedOn,
        createdById,
        updatedById,
      ];

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['Id'],
      cardId: map['CardId'],
      firmId: map['FirmId'],
      cardCode: map['CardCode'],
      imageName: map['ImageName'],
      accountNumber: map['AccountNumber'],
      fromMonth: map['FromMonth'],
      fromYear: map['FromYear'],
      toMonth: map['ToMonth'],
      toYear: map['ToYear'],
      cardHolderName: map['CardHolderName'],
      organizationName: map['OrganizationName'],
      image: map['Image'],
      qrCodeImage: map['QRCodeImage'],
      createdOn: DateTime.parse(map['CreatedOn']),
      updatedOn: map['UpdatedOn'] != null ? DateTime.parse(map['UpdatedOn']) : null,
      createdById: map['CreatedById'],
      updatedById: map['UpdatedById'],
    );
  }

  factory CardModel.fromJson(String source) => CardModel.fromMap(json.decode(source));
}
