import 'package:aim_business/business.dart';
import 'package:aim_common/common.dart';
import 'package:aim_datas/datas.dart';
import 'package:aim_models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aim/presentation_constants/presentation_contants_barrel.dart';
import 'package:aim/presentations/widgets/widgets.dart';

import 'forms/transaction_modify_screen.dart';

part 'components/transaction_item.dart';
part 'components/transaction_methods.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final List<TransactionModel> transactions = [];
  DateTime startDateTime = DateTime(DateTime.now().year, DateTime.now().month);
  DateTime endDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _invokeFetchRecords(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personal Transaction")),
      body: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (_, state) async {
          if (state is TransactionStateModifySuccess) {
            _invokeFetchRecords(context);
          }
          if (state is TransactionStateDeleteSuccess) {
            transactions.removeWhere((item) => item.id == state.id);
            context.read<TransactionBloc>().add(TransactionEventInitial());
          }
          if (state is TransactionStateDeleteError) {
            await showAlertDialog(context, contentText: state.message);
          }
        },
        builder: (_, state) {
          return Column(
            children: [
              _datePickerContainer(context),
              Expanded(
                child: Builder(
                  builder: (_) {
                    if (state is TransactionStateFetchLoading || state is TransactionStateDeleteLoading) {
                      return ATLoaderWidget();
                    }
                    if (state is TransactionStateFetchError) {
                      return Center(
                        child: ATErrorWidget(
                          imageHeight: MediaQuery.of(context).size.height * 0.3,
                          errorMessages: ["Error while fetching records.", "Please try again later."],
                        ),
                      );
                    }
                    if (state is TransactionStateFetchSuccess) {
                      transactions.clear();
                      transactions.addAll(state.transactions);
                    }
                    if (transactions.length > 0) {
                      return ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.only(top: 5),
                        itemCount: transactions.length,
                        shrinkWrap: true,
                        itemBuilder: (_, index) => TransactionItem(transaction: transactions[index]),
                      );
                    } else {
                      return Center(child: ATNoRecordsFoundWidget(imageHeight: MediaQuery.of(context).size.height * 0.3));
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTransaction,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );
  }

  Container _datePickerContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(color: AIMColors.primaryColor, borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("From Date: ", style: TextStyle(color: Colors.white)),
              Spacer(),
              Text(this.startDateTime.format("dd MMM, yyyy"), style: TextStyle(color: Colors.white)),
              SizedBox(width: 60),
              GestureDetector(
                onTap: () => showDatePickerWidget(context, selectedDateTime: this.startDateTime).then(
                  (value) {
                    this.startDateTime = value;
                    _invokeFetchRecords(context);
                  },
                ),
                child: Icon(Icons.date_range, color: Colors.white),
              )
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text("To Date: ", style: TextStyle(color: Colors.white)),
              Spacer(),
              Text(this.endDateTime.format("dd MMM, yyyy"), style: TextStyle(color: Colors.white)),
              SizedBox(width: 60),
              GestureDetector(
                onTap: () => showDatePickerWidget(context, selectedDateTime: this.endDateTime).then(
                  (value) {
                    this.endDateTime = value;
                    _invokeFetchRecords(context);
                  },
                ),
                child: Icon(Icons.date_range, color: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _invokeFetchRecords(BuildContext context) async {
    context.read<TransactionBloc>().add(
          TransactionEventRequest(
            oDataParams: getODataParameters(
              userId: (await context.read<FirmContextStore>().getUserContext())?.firmUserId ?? 0,
              startDateTime: this.startDateTime,
              endDateTime: this.endDateTime,
            ),
          ),
        );
  }

  void _addTransaction() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TransactionModifyScreen(
          TransactionModifyModel(
            transactionId: 0,
            transactionTypeId: TransactionType.INCOME,
            title: "",
            amount: 0,
            shortDescription: "",
          ),
        ),
      ),
    );
  }
}
