import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ATNumberInput extends StatelessWidget {
  final String labelText;
  final int? value;
  final bool isRequired;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final Function(int? value)? onChange;
  final String? Function(int? value)? customValidation;

  const ATNumberInput({
    Key? key,
    this.labelText = "",
    this.value,
    this.isRequired = false,
    this.textInputAction,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChange,
    this.customValidation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value?.toString(),
      focusNode: focusNode,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(labelText: labelText),
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: (val) {
        this.onChange!(val.isEmpty ? null : int.parse(val));
      },
      validator: (val) {
        if (isRequired && (val == null || val.isEmpty)) {
          return "$labelText is required.";
        }
        if (this.customValidation != null) {
          return this.customValidation!(val!.isEmpty ? null : int.parse(val));
        }
        return null;
      },
    );
  }
}
