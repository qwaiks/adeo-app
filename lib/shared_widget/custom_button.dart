import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final bool isOutline;
  final String text;
  final Color textColor;
  final Function onPressed;

  const CustomButton(
      {Key key,
      this.isOutline = false,
      this.text,
      this.onPressed,
      this.textColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        side: MaterialStateProperty.all(
            BorderSide(color: Colors.white, width: 2.0)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 11),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 21, fontWeight: FontWeight.w600, color: textColor),
        ),
      ),
    );
  }
}
