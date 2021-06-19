import 'package:aim_business/business.dart';
import 'package:aim_common/common.dart';
import 'package:aim_datas/datas.dart';
import 'package:aim_models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aim/presentation_constants/color_constant.dart';
import 'package:aim/presentations/screens/cards/forms/card_modify_screen.dart';
import 'package:aim/presentations/widgets/widgets.dart';

part 'components/card_item.dart';
part 'components/card_qr_code.dart';

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final List<CardModel> cards = [];

  @override
  void initState() {
    super.initState();
    _invokeFetchRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Card")),
      body: BlocConsumer<CardBloc, CardState>(
        listener: (_, state) async {
          if (state is CardStateModifySuccess) {
            _invokeFetchRecords();
          }
          if (state is CardStateDeleteSuccess) {
            cards.removeWhere((item) => item.id == state.id);
            context.read<CardBloc>().add(CardEventInitial());
          }
          if (state is CardStateDeleteError) {
            await showAlertDialog(context, contentText: state.message);
          }
        },
        builder: (_, state) {
          if (state is CardStateFetchLoading || state is CardStateDeleteLoading) {
            return ATLoaderWidget();
          }
          if (state is CardStateFetchError) {
            return Center(
              child: ATErrorWidget(
                imageHeight: MediaQuery.of(context).size.height * 0.4,
                errorMessages: ["Error while fetching records.", "Please try again later."],
              ),
            );
          }
          if (state is CardStateFetchSuccess) {
            cards.clear();
            cards.addAll(state.cards);
          }
          if (cards.length > 0) {
            return ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 5),
              itemCount: cards.length,
              shrinkWrap: true,
              itemBuilder: (_, index) => CardItem(card: cards[index]),
            );
          } else {
            return Center(child: ATNoRecordsFoundWidget(imageHeight: MediaQuery.of(context).size.height * 0.4));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCard,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );
  }

  void _invokeFetchRecords() async {
    context.read<CardBloc>().add(
          CardEventFetchRequest(
            oDataParams: ODataParametersModel(filter: "CreatedById == ${(await context.read<FirmContextStore>().getUserContext())?.firmUserId ?? 0}"),
          ),
        );
  }

  void _addCard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CardModifyScreen(
          CardModifyModel(
            cardId: 0,
            accountNumber: "",
            cardHolderName: "",
            organizationName: "",
            fromMonth: 0,
            fromYear: 0,
            toMonth: 0,
            toYear: 0,
          ),
        ),
      ),
    );
  }
}
