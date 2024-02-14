import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final double size;
  final Color activeColor;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.size = 24.0,
    this.activeColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: value ? activeColor : Colors.transparent,
          border: Border.all(
            color: activeColor,
            width: 1.5,
          ),
        ),
        child: value
            ? Icon(
          Icons.lock,
          size: size * 0.7,
          color: Colors.white,
        )
            : null,
      ),
    );
  }
}