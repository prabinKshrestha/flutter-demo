import 'package:flutter/material.dart';

class ATSubmitButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPress;
  final bool disabled;
  final bool isLoading;

  const ATSubmitButton({
    Key? key,
    this.text = "Save",
    this.disabled = false,
    this.isLoading = false,
    required this.color,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(this.disabled ? color.withOpacity(0.4) : color)),
      onPressed: () {
        FocusScope.of(context).unfocus();
        if (!this.disabled) {
          this.onPress();
        }
      },
      child: Row(mainAxisSize: MainAxisSize.min, children: [Text(text)]),
    );
  }
}
