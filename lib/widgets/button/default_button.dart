import 'package:flutter/material.dart';


class DefaultButton extends StatelessWidget {

  final Function onPressed;
  final Widget child;
  final Color color;
  final Color textColor;

  DefaultButton({
    @required this.onPressed,
    @required this.child,
    @required this.color,
    @required this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      textColor: this.textColor,
      onPressed: this.onPressed,
      child: this.child,
      color: this.color,
    );
  }
}