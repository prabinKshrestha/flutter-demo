part of "../transaction_report_screen.dart";

class TransactionReportPieChart extends StatefulWidget {
  final List<TransactionModel> transactions;

  TransactionReportPieChart({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  @override
  _TransactionReportPieChartState createState() => _TransactionReportPieChartState();
}

class _TransactionReportPieChartState extends State<TransactionReportPieChart> {
  int touchedIndex = -1;
  double expenses = 0;
  double incomes = 0;

  @override
  void initState() {
    super.initState();
    widget.transactions.where((e) => e.isExpenses).forEach((e) => expenses += e.amount);
    widget.transactions.where((e) => !e.isExpenses).forEach((e) => incomes += e.amount);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 2, offset: Offset(0, 5))],
        ),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                    setState(() {
                      final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent && pieTouchResponse.touchInput is! PointerUpEvent;
                      touchedIndex =
                          desiredTouch && pieTouchResponse.touchedSection != null ? pieTouchResponse.touchedSection!.touchedSectionIndex : -1;
                    });
                  }),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 3,
                  centerSpaceRadius: 25,
                  sections: _getPieChartSection(),
                ),
              ),
            ),
            Spacer(),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChartIndicator(color: AIMColors.secondaryColor_600, text: 'Income'),
                SizedBox(height: 6),
                ChartIndicator(color: AIMColors.primaryColor_600, text: 'Expenses'),
                SizedBox(height: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _getPieChartSection() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 15 : 12;
      final double radius = isTouched ? 60 : 50;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AIMColors.primaryColor_600,
            value: expenses / (expenses + incomes) * 100,
            title: '$expenses',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
          );
        case 1:
          return PieChartSectionData(
            color: AIMColors.secondaryColor_600,
            value: incomes / (expenses + incomes) * 100,
            title: '$incomes',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
          );
        default:
          return PieChartSectionData();
      }
    });
  }
}
