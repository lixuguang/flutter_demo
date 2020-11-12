

import 'package:flutter/material.dart';

class ShadowButton extends StatelessWidget {

  final String text;
  final EdgeInsets padding;
  final BorderRadiusGeometry borderRadius;
  final TextStyle textStyle;
  final Function onPressed;

  ShadowButton({
    @required this.text,
    @required this.onPressed,
    this.padding = const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
    this.borderRadius = const BorderRadius.all(Radius.zero),
    this.textStyle
  });

  @override
  Widget build(BuildContext context) {
    final Color themeColor = Theme.of(context).primaryColor;

    return GestureDetector(
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: themeColor,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: themeColor,
              offset: Offset(0, 0.8),
              blurRadius: 3.0,
              spreadRadius: 0,
            )
          ]
        ),
        child: Text(
          text,
          style: textStyle,
        ),
      ),
      onTap: onPressed
    );
  }

}