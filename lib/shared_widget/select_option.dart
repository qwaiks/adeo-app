import 'package:flutter/material.dart';

class OptionSelect extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function onPressed;

  const OptionSelect(
      {Key key, this.isSelected = false, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: isSelected ? 38 : 16, color: Colors.white),
        ));
  }
}
