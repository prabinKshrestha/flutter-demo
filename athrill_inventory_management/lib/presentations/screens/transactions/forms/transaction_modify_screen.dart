import 'package:aim_business/business.dart';
import 'package:aim_common/common.dart';
import 'package:aim_models/models.dart';
import 'package:aim/presentation_constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:aim/presentations/widgets/widgets.dart';

part 'transaction_form.dart';

/// Screen to Modify Transaction
///
/// Note: This is used for both Add and Update Action
class TransactionModifyScreen extends StatelessWidget {
  final TransactionModifyModel transactionModifyModel;

  TransactionModifyScreen(this.transactionModifyModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${transactionModifyModel.isAdd ? "Add" : "Update"} Transaction")),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: TransactionForm(this.transactionModifyModel),
        ),
      ),
    );
  }
}
