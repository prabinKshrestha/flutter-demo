import 'package:flutter/material.dart';

class ATDropdownInput<T> extends StatelessWidget {
  final String labelText;
  final T? value;
  final List data;
  final String displayField;
  final String valueField;
  final bool isRequired;
  final FocusNode? focusNode;

  final Function(T? value)? onChange;

  ATDropdownInput({
    Key? key,
    this.labelText = "",
    this.value,
    required this.data,
    required this.displayField,
    required this.valueField,
    this.isRequired = false,
    this.focusNode,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T tempValue = value == null ? data.first[valueField] : value;

    return DropdownButtonFormField<T>(
      value: tempValue,
      focusNode: focusNode,
      decoration: InputDecoration(labelText: labelText),
      items: data.map((item) => DropdownMenuItem<T>(value: item[valueField], child: Text(item[displayField]))).toList(),
      onChanged: (T? newValue) {
        this.onChange!(newValue);
      },
      validator: (val) {
        if (isRequired && (val == null)) {
          return "$labelText is required.";
        }
        return null;
      },
    );
  }
}
