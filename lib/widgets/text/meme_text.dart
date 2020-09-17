import 'package:flutter/material.dart';
import 'package:meme_generator_app/models/text_info.dart';

class MemeText extends StatefulWidget {
  final TextInfo textInfo;

  MemeText({@required this.textInfo});

  @override
  _MemeTextState createState() => _MemeTextState();
}

class _MemeTextState extends State<MemeText> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.textInfo.text,
        textAlign: widget.textInfo.textAlign,
        style: TextStyle(
          fontSize: this.widget.textInfo.fontSize,
          fontWeight: this.widget.textInfo.fontWeight,
          fontStyle: this.widget.textInfo.fontStyle,
          color: this.widget.textInfo.color,
        ));
  }
}
