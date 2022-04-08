import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final bool isOutline;
  final String text;
  final Function onPressed;

  const CustomButton(
      {Key key, this.isOutline = false, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
