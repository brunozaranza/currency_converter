import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrencyText extends StatelessWidget {
  final String text;

  CurrencyText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.blueAccent),
      textAlign: TextAlign.center,
    );
  }
}
