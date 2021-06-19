import 'dart:convert';

import 'package:aim_common/common.dart';
import 'package:equatable/equatable.dart';

import '../at_datas/at_datas_model_barrel.dart';

class TransactionModel extends Equatable {
  final int id;
  final int transactionId;
  final int firmId;
  final int transactionTypeId;
  final String title;
  final int amount;
  final String shortDescription;
  final DateTime createdOn;
  final DateTime? updatedOn;
  final int createdById;
  final int updatedById;

  final ATDataValueModel? transactionType;

  get isExpenses {
    return transactionTypeId == TransactionType.EXPENSES;
  }

  TransactionModel({
    required this.id,
    required this.transactionId,
    required this.firmId,
    required this.transactionTypeId,
    required this.title,
    required this.amount,
    required this.shortDescription,
    required this.createdOn,
    this.updatedOn,
    required this.createdById,
    required this.updatedById,
    this.transactionType,
  });

  @override
  List<Object?> get props => [
        id,
        transactionId,
        firmId,
        transactionTypeId,
        title,
        amount,
        shortDescription,
        createdOn,
        updatedOn,
        createdById,
        updatedById,
        transactionType
      ];

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['Id'],
      transactionId: map['TransactionId'],
      firmId: map['FirmId'],
      transactionTypeId: map['TransactionTypeId'],
      title: map['Title'],
      amount: map['Amount'],
      shortDescription: map['ShortDescription'],
      createdOn: DateTime.parse(map['CreatedOn']),
      updatedOn: map['UpdatedOn'] != null ? DateTime.parse(map['UpdatedOn']) : null,
      createdById: map['CreatedById'],
      updatedById: map['UpdatedById'],
      transactionType: map['TransactionType'] != null ? ATDataValueModel.fromMap(map['TransactionType']) : null,
    );
  }

  factory TransactionModel.fromJson(String source) => TransactionModel.fromMap(json.decode(source));
}
