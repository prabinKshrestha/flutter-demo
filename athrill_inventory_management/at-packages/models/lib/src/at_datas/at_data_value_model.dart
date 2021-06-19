import 'package:equatable/equatable.dart';

import 'at_data_type_model.dart';

class ATDataValueModel extends Equatable {
  final int id;
  final int atDataTypeId;
  final String displayName;
  final String value;
  final String description;
  final bool isActive;
  final DateTime createdOn;
  final DateTime? updatedOn;
  final int createdById;
  final int updatedById;
  final ATDataTypeModel? atDataType;

  ATDataValueModel({
    required this.id,
    required this.atDataTypeId,
    required this.displayName,
    required this.value,
    required this.description,
    required this.isActive,
    required this.createdOn,
    this.updatedOn,
    required this.createdById,
    required this.updatedById,
    this.atDataType,
  });

  @override
  List<Object?> get props =>
      [id, atDataTypeId, displayName, value, description, isActive, createdOn, updatedOn, createdById, updatedById, atDataType];

  factory ATDataValueModel.fromMap(Map<String, dynamic> map) {
    return ATDataValueModel(
      id: map['Id'],
      atDataTypeId: map['ATDataTypeId'],
      displayName: map['DisplayName'],
      value: map['Value'],
      description: map['Description'],
      isActive: map['IsActive'],
      createdOn: DateTime.parse(map['CreatedOn']),
      updatedOn: map['UpdatedOn'] != null ? DateTime.parse(map['UpdatedOn']) : null,
      createdById: map['CreatedById'],
      updatedById: map['UpdatedById'],
      atDataType: ATDataTypeModel.fromMap(map['ATDataType']),
    );
  }
}
