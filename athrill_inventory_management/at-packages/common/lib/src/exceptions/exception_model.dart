import 'package:equatable/equatable.dart';

class ErrorLevel {
  static const int Error = 1;
  static const int Warning = 2;
  static const int Information = 3;
}

class BusinessExceptionMessageModel extends Equatable {
  final int errorLevel;
  final String message;
  final String? targetType;

  BusinessExceptionMessageModel({
    required this.errorLevel,
    required this.message,
    this.targetType,
  });

  @override
  List<Object?> get props => [errorLevel, message, targetType];

  factory BusinessExceptionMessageModel.fromMap(Map<String, dynamic> map) {
    return BusinessExceptionMessageModel(
      errorLevel: map['ErrorLevel'],
      message: map["Message"],
      targetType: map['TargetType'],
    );
  }
}

class BusinessExceptionModel extends Equatable {
  final List<BusinessExceptionMessageModel> validations;
  final String message;

  BusinessExceptionModel({
    required this.validations,
    required this.message,
  });

  @override
  List<Object?> get props => [message, validations];

  factory BusinessExceptionModel.fromMap(Map<String, dynamic> map) {
    return BusinessExceptionModel(
      validations: List<BusinessExceptionMessageModel>.from(map['Validations']?.map((x) => BusinessExceptionMessageModel.fromMap(x))),
      message: map['Message'],
    );
  }
}
