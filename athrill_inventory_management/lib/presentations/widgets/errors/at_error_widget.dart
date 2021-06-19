import 'package:flutter/material.dart';

class ATErrorWidget extends StatelessWidget {
  final List<String> errorMessages;
  final double imageHeight;

  const ATErrorWidget({
    Key? key,
    required this.errorMessages,
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
          child: Image(image: AssetImage("assets/images/error.png")),
        ),
        SizedBox(height: 40),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: List.generate(errorMessages.length, (index) {
                return Text(errorMessages[index], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500));
              }),
            )),
      ],
    );
  }
}
