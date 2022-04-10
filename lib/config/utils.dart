import 'package:flutter/material.dart';
import 'package:html/parser.dart';

verticalSpacer({double space = 16}) {
  return SizedBox(
    height: space,
  );
}

horizontalSpacer({double space = 16}) {
  return SizedBox(
    width: space,
  );
}

class Utils{
 static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }
}
