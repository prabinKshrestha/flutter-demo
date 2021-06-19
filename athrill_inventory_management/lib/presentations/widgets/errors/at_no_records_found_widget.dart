import 'package:flutter/material.dart';

class ATNoRecordsFoundWidget extends StatelessWidget {
  final double imageHeight;

  const ATNoRecordsFoundWidget({
    Key? key,
    required this.imageHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: imageHeight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Image(image: AssetImage("assets/images/no_records.png")),
        ),
        SizedBox(height: 40),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text("No Records Found", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        )
      ],
    );
  }
}
