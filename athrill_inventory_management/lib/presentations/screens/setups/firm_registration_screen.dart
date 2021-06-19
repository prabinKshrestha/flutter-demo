import 'package:aim_business/business.dart';
import 'package:aim_datas/datas.dart';
import 'package:aim_models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:aim/presentation_constants/presentation_contants_barrel.dart';
import 'package:aim/presentations/widgets/widgets.dart';

part 'components/firm_registration_form.dart';

class FirmRegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FirmRegisterBloc(firmRepository: context.read<FirmRepository>(), firmContextStore: context.read<FirmContextStore>()),
      child: Scaffold(
        appBar: AppBar(title: Text("Firm Setup")),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: FirmRegistrationForm(),
          ),
        ),
      ),
    );
  }
}
