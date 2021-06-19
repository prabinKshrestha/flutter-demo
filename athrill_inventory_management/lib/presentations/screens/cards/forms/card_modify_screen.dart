import 'package:aim_business/business.dart';
import 'package:aim_models/models.dart';
import 'package:aim/presentation_constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:aim/presentations/widgets/widgets.dart';

part 'card_form.dart';

/// Screen to Modify Card
///
/// Note: This is used for both Add and Update Action
class CardModifyScreen extends StatelessWidget {
  final CardModifyModel cardModifyModel;

  CardModifyScreen(this.cardModifyModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${cardModifyModel.isAdd ? "Add" : "Update"} Card")),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: CardForm(this.cardModifyModel),
        ),
      ),
    );
  }
}
