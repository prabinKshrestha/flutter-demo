import 'package:equatable/equatable.dart';

class ATDataTypeModel extends Equatable {
  final int id;
  final String nameKey;
  final String displayName;
  final String description;
  final bool isActive;
  final DateTime createdOn;
  final DateTime? updatedOn;
  final int createdById;
  final int updatedById;

  ATDataTypeModel({
    required this.id,
    required this.nameKey,
    required this.displayName,
    required this.description,
    required this.isActive,
    required this.createdOn,
    this.updatedOn,
    required this.createdById,
    required this.updatedById,
  });

  @override
  List<Object?> get props => [id, nameKey, displayName, description, isActive, createdOn, updatedOn, createdById, updatedById];

  factory ATDataTypeModel.fromMap(Map<String, dynamic> map) {
    return ATDataTypeModel(
      id: map['Id'],
      nameKey: map['NameKey'],
      displayName: map['DisplayName'],
      description: map['Description'],
      isActive: map['IsActive'],
      createdOn: DateTime.parse(map['CreatedOn']),
      updatedOn: map['UpdatedOn'] != null ? DateTime.parse(map['UpdatedOn']) : null,
      createdById: map['CreatedById'],
      updatedById: map['UpdatedById'],
    );
  }
}
