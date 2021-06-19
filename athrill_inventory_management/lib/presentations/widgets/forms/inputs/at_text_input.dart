import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ATTextInput extends StatelessWidget {
  final String labelText;
  final String? value;
  final bool isRequired;
  final TextInputType keyboardType;
  final int? minLines;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final int? maxLength;
  final List<TextInputFormatter> formatters;
  final Function(String value)? onFieldSubmitted;
  final Function(String? value)? onChange;
  final String? Function(String? value)? customValidation;

  ATTextInput({
    Key? key,
    this.labelText = "",
    this.value,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.minLines = 1,
    this.maxLines = 4,
    this.maxLength,
    this.textInputAction,
    this.focusNode,
    this.formatters = const [],
    this.onFieldSubmitted,
    this.onChange,
    this.customValidation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      focusNode: focusNode,
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: InputDecoration(labelText: labelText),
      textInputAction: textInputAction,
      inputFormatters: formatters,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: (val) {
        this.onChange!(val);
      },
      validator: (val) {
        if (isRequired && (val == null || val.isEmpty)) {
          return "$labelText is required.";
        }
        if (this.customValidation != null) {
          return this.customValidation!(val);
        }
        return null;
      },
    );
  }
}
