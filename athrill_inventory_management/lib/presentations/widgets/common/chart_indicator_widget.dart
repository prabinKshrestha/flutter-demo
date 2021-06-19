import 'package:flutter/material.dart';

class ChartIndicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const ChartIndicator({
    Key? key,
    required this.color,
    required this.text,
    this.isSquare = true,
    this.size = 16,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(shape: isSquare ? BoxShape.rectangle : BoxShape.circle, color: color),
        ),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: textColor))
      ],
    );
  }
}
