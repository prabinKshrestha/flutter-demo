import 'package:aim_business/business.dart';
import 'package:aim_common/common.dart';
import 'package:aim_datas/datas.dart';
import 'package:aim_models/models.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:aim/presentation_constants/presentation_contants_barrel.dart';
import 'package:aim/presentations/widgets/widgets.dart';

part 'components/transaction_report_methods.dart';
part 'components/transaction_report_pie_chart.dart';
part 'components/transaction_report_line_chart.dart';
part 'components/transaction_report_bar_chart.dart';

class TransactionReportScreen extends StatefulWidget {
  @override
  _TransactionReportScreenState createState() => _TransactionReportScreenState();
}

class _TransactionReportScreenState extends State<TransactionReportScreen> {
  final List<TransactionModel> transactions = [];
  DateTime startDateTime = DateTime(DateTime.now().year, DateTime.now().month);
  DateTime endDateTime = DateTime.now();

  @override
  void initState() {
    _invokeFetchRecords(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personal Transaction Report")),
      body: BlocBuilder<TransactionReportBloc, TransactionReportState>(
        builder: (_, state) {
          return Column(
            children: [
              _datePickerContainer(context),
              Expanded(
                child: Builder(
                  builder: (_) {
                    if (state is TransactionReportStateFetchLoading) {
                      return ATLoaderWidget();
                    }
                    if (state is TransactionReportStateFetchError) {
                      return Center(
                        child: ATErrorWidget(
                          imageHeight: MediaQuery.of(context).size.height * 0.3,
                          errorMessages: ["Error while fetching records.", "Please try again later."],
                        ),
                      );
                    }
                    if (state is TransactionReportStateFetchSuccess) {
                      transactions.clear();
                      transactions.addAll(state.transactions);
                    }
                    if (transactions.length > 0) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
                        child: Column(
                          children: [
                            TransactionReportPieChart(transactions: transactions),
                            SizedBox(height: 20),
                            TransactionReportLineChart(
                              transactions: transactions,
                              startDateTime: this.startDateTime,
                              endDateTime: this.endDateTime,
                              isExpenses: true,
                            ),
                            SizedBox(height: 20),
                            TransactionReportLineChart(
                              transactions: transactions,
                              startDateTime: this.startDateTime,
                              endDateTime: this.endDateTime,
                              isExpenses: false,
                            ),
                            SizedBox(height: 20),
                            TransactionReportBarChart(
                              transactions: transactions,
                              startDateTime: this.startDateTime,
                              endDateTime: this.endDateTime,
                            ),
                          ],
                        ),
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
    context.read<TransactionReportBloc>().add(
          TransactionReportEventRequest(
            oDataParams: TransactionReportScreenMethods.getODataParameters(
              userId: (await context.read<FirmContextStore>().getUserContext())?.firmUserId ?? 0,
              startDateTime: this.startDateTime,
              endDateTime: this.endDateTime,
            ),
          ),
        );
  }
}
