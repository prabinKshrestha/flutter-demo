import 'package:equatable/equatable.dart';

class ODataParametersModel extends Equatable {
  final String? expand;
  final String? filter;
  final String? order;
  final int? top;
  final int? skip;

  ODataParametersModel({
    this.expand,
    this.filter,
    this.order,
    this.top,
    this.skip,
  });

  Map<String, dynamic> getJSONObjectForAPICall() {
    Map<String, dynamic> retVal = {};
    if (expand != null && expand!.isNotEmpty) {
      retVal.addAll({'\$expand': expand});
    }
    if (filter != null && filter!.isNotEmpty) {
      retVal.addAll({'\$filter': filter});
    }
    if (order != null && order!.isNotEmpty) {
      retVal.addAll({'\$order': order});
    }
    if (top != null) {
      retVal.addAll({'\$top': top});
    }
    if (skip != null) {
      retVal.addAll({'\$skip': skip});
    }
    return retVal;
  }

  @override
  List<Object?> get props => [];
}
