import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final bool isOutline;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Function onPressed;

  const CustomButton(
      {Key key,
      this.isOutline = false,
      this.text,
      this.backgroundColor = Colors.green,
      this.onPressed,
      this.textColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final outline = OutlinedButton(
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

    final long = ElevatedButton(
      onPressed: onPressed,
      //color: backgroundColor,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          minimumSize: MaterialStateProperty.all(Size(double.infinity, 51))),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 21, fontWeight: FontWeight.w600, color: textColor),
      ),
    );
    return isOutline ? outline : long;
  }
}
