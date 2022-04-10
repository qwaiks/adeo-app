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

class Utils {
  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString.isEmpty? 'Sorry cannot find question': parsedString;
  }

  static List<String> parseHtmlImages(String htmlString) {
    var document = parse(htmlString);
    var imgList = document.querySelectorAll("img");

    return imgList.map((e) => e.toString()).toList() ?? [];
  }
}
