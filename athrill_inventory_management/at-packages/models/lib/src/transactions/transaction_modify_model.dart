import 'dart:convert';

import 'package:equatable/equatable.dart';

class TransactionModifyModel extends Equatable {
  final int transactionId;
  final int transactionTypeId;
  final String title;
  final int amount;
  final String shortDescription;

  get isAdd {
    return transactionId == 0;
  }

  TransactionModifyModel({
    required this.transactionId,
    required this.transactionTypeId,
    required this.title,
    required this.amount,
    required this.shortDescription,
  });

  @override
  List<Object?> get props => [transactionId, transactionTypeId, title, amount, shortDescription];

  Map<String, dynamic> toMap() {
    return {
      'transactionId': transactionId,
      'transactionTypeId': transactionTypeId,
      'title': shortDescription.length >= 50 ? shortDescription.toString().substring(0, 50) : shortDescription,
      'amount': amount,
      'shortDescription': shortDescription,
    };
  }

  String toJson() => json.encode(toMap());

  TransactionModifyModel copyWith({
    int? transactionId,
    int? transactionTypeId,
    String? title,
    int? amount,
    String? shortDescription,
  }) {
    return TransactionModifyModel(
      transactionId: transactionId ?? this.transactionId,
      transactionTypeId: transactionTypeId ?? this.transactionTypeId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      shortDescription: shortDescription ?? this.shortDescription,
    );
  }
}
