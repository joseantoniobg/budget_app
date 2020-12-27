import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String _caption;
  final Function _onPressed;
  final TextStyle _textStyle;
  final Color _usedColor;

  AdaptiveFlatButton(
      this._caption, this._onPressed, this._textStyle, this._usedColor);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: _onPressed,
            child: Text(
              _caption,
              style: _textStyle,
            ))
        : FlatButton(
            onPressed: _onPressed,
            textColor: _usedColor,
            child: Text(
              _caption,
              style: _textStyle,
            ));
  }
}
