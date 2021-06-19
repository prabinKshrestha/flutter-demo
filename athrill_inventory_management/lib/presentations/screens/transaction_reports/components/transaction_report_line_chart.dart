part of "../transaction_report_screen.dart";

class TransactionReportLineChart extends StatefulWidget {
  final List<TransactionModel> transactions;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final bool isExpenses;

  TransactionReportLineChart({
    Key? key,
    required this.transactions,
    required this.startDateTime,
    required this.endDateTime,
    required this.isExpenses,
  }) : super(key: key);

  @override
  _TransactionReportLineChartState createState() => _TransactionReportLineChartState();
}

class _TransactionReportLineChartState extends State<TransactionReportLineChart> {
  List<DateTime> dateTimecollection = [];
  List<double> amountCollection = [];

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
        aspectRatio: 1.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 20),
            Text("${widget.isExpenses ? 'Expenses' : 'Income'}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            SizedBox(height: 5),
            Text("Touch graph to view data.", style: TextStyle(fontSize: 10)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                        getTooltipItems: _getGraphTooltip,
                      ),
                      handleBuiltInTouches: true,
                    ),
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: false),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        left: BorderSide(color: Colors.grey),
                        bottom: BorderSide(color: Colors.grey),
                      ),
                    ),
                    minX: 0,
                    minY: 0,
                    lineBarsData: _getLineGraphData(),
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

  List<LineChartBarData> _getLineGraphData() {
    return [
      LineChartBarData(
        spots: _getSpots(),
        isCurved: true,
        colors: [widget.isExpenses ? AIMColors.primaryColor_600 : AIMColors.secondaryColor_600],
        barWidth: 1,
        curveSmoothness: 0,
        isStrokeCapRound: false,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: true, colors: [widget.isExpenses ? AIMColors.primaryColor_100 : AIMColors.secondaryColor_100]),
      ),
    ];
  }

  List<FlSpot> _getSpots() {
    int i = 0;
    return amountCollection.map((d) {
      i++;
      return FlSpot(i.toDouble(), d);
    }).toList();
  }

  List<LineTooltipItem> _getGraphTooltip(List<LineBarSpot> data) {
    return data
        .map(
          (e) => LineTooltipItem(
            "Amount: ${amountCollection[e.spotIndex]} \n Date: ${dateTimecollection[e.spotIndex].format("yyyy-m-dd")}",
            TextStyle(),
          ),
        )
        .toList();
  }

  void _setAmount() {
    amountCollection = dateTimecollection.map((d) {
      double amountTotal = 0;
      widget.transactions
          .where((e) =>
              e.isExpenses == widget.isExpenses &&
              (e.createdOn.isAtSameMomentAs(d) || (e.createdOn.isAfter(d) && e.createdOn.isBefore(d.add(Duration(days: 1))))))
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
