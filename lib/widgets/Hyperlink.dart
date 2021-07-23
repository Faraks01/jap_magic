import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Hyperlink extends StatelessWidget {
  final String url;
  final TextStyle style;
  final String text;

  Hyperlink(this.text, {Key key, this.style, @required this.url})
      : super(key: key);

  Future<void> handleTextTap() async {
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTextTap,
      child: Text(
        text,
        style: style != null
            ? style.merge(TextStyle(color: Colors.blue[700]))
            : null,
      ),
    );
  }
}
