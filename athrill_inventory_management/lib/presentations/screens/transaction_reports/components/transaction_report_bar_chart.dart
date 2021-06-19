part of "../transaction_report_screen.dart";

class TransactionReportBarChart extends StatefulWidget {
  final List<TransactionModel> transactions;
  final DateTime startDateTime;
  final DateTime endDateTime;

  TransactionReportBarChart({
    Key? key,
    required this.transactions,
    required this.startDateTime,
    required this.endDateTime,
  }) : super(key: key);

  @override
  _TransactionReportBarChartState createState() => _TransactionReportBarChartState();
}

class _TransactionReportBarChartState extends State<TransactionReportBarChart> {
  final double width = 5;

  List<DateTime> dateTimecollection = [];
  List<double> expensescollection = [];
  List<double> incomescollection = [];

  @override
  void initState() {
    super.initState();
    _setDateTimeCollection();
    _setAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 2, offset: Offset(0, 5))],
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 20),
            Text("Expenses/Income", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            SizedBox(height: 5),
            Text("Touch bar to view data.", style: TextStyle(fontSize: 10)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: BarChart(
                  BarChartData(
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                        getTooltipItem: _getGraphTooltip,
                      ),
                      handleBuiltInTouches: true,
                    ),
                    minY: 0,
                    titlesData: FlTitlesData(show: false),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        left: BorderSide(color: Colors.grey),
                        bottom: BorderSide(color: Colors.grey),
                      ),
                    ),
                    barGroups: _getBarChartGroups(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  BarTooltipItem _getGraphTooltip(group, groupIndex, rod, rodIndex) {
    return BarTooltipItem(
      "Amount: ${rodIndex == 0 ? expensescollection[groupIndex] : incomescollection[groupIndex]} \n Date: ${dateTimecollection[groupIndex].format("yyyy-m-dd")}",
      TextStyle(),
    );
  }

  List<BarChartGroupData> _getBarChartGroups() {
    int i = 0;
    return dateTimecollection.map((d) {
      i++;
      return _getBarChartGroupData(i, expensescollection[i - 1], incomescollection[i - 1]);
    }).toList();
  }

  BarChartGroupData _getBarChartGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(y: y1, colors: [AIMColors.primaryColor_600], width: width),
        BarChartRodData(y: y2, colors: [AIMColors.secondaryColor_600], width: width),
      ],
    );
  }

  void _setAmount() {
    expensescollection = dateTimecollection.map((d) {
      double amountTotal = 0;
      widget.transactions
          .where(
            (e) => e.isExpenses && (e.createdOn.isAtSameMomentAs(d) || (e.createdOn.isAfter(d) && e.createdOn.isBefore(d.add(Duration(days: 1))))),
          )
          .forEach((e) => amountTotal += e.amount);
      return amountTotal;
    }).toList();
    incomescollection = dateTimecollection.map((d) {
      double amountTotal = 0;
      widget.transactions
          .where(
            (e) => !e.isExpenses && (e.createdOn.isAtSameMomentAs(d) || (e.createdOn.isAfter(d) && e.createdOn.isBefore(d.add(Duration(days: 1))))),
          )
          .forEach((e) => amountTotal += e.amount);
      return amountTotal;
    }).toList();
  }

  void _setDateTimeCollection() {
    DateTime startDateTime = widget.startDateTime.removeTimeParameters();
    DateTime endDateTime = widget.endDateTime.removeTimeParameters();
    while (startDateTime.isBefore(endDateTime) || startDateTime.isAtSameMomentAs(endDateTime)) {
      dateTimecollection.add(startDateTime);
      startDateTime = startDateTime.add(Duration(days: 1));
    }
  }
}
