import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final ValueChanged<String>? onChanged;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.selectedValue,
    this.onChanged,
  }) : super(key: key);
//ok
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      onChanged: onChanged != null ? (String? value) => onChanged!(value!) : null,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      menuMaxHeight: 250,
    );
  }
}
