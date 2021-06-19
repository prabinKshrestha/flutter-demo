import 'package:equatable/equatable.dart';

class FirmModel extends Equatable {
  final int id;
  final int firmId;
  final String firmName;
  final DateTime createdOn;
  final DateTime? updatedOn;
  final int createdById;
  final int updatedById;

  FirmModel({
    required this.id,
    required this.firmId,
    required this.firmName,
    required this.createdOn,
    this.updatedOn,
    required this.createdById,
    required this.updatedById,
  });

  factory FirmModel.fromMap(Map<String, dynamic> map) {
    return FirmModel(
      id: map['Id'],
      firmId: map['FirmId'],
      firmName: map['FirmName'],
      createdOn: DateTime.parse(map['CreatedOn']),
      updatedOn: map['UpdatedOn'] != null ? DateTime.parse(map['UpdatedOn']) : null,
      createdById: map['CreatedById'],
      updatedById: map['UpdatedById'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        firmId,
        firmName,
        createdOn,
        updatedOn,
        createdById,
        updatedById,
      ];
}
