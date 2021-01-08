import 'package:flutter/material.dart';

class StringUtil {
  static String formatToDecimalPlaces(
      {@required int decimalPlaces, @required double value}) {

    if(value == null) return "";

    if(value.toString().contains(".")) {
      String decimals = value.toString().split(".")[1];
      decimalPlaces = decimals.length >= 2 ? decimalPlaces : decimals.length;
    }

    return value.toStringAsFixed(value.truncateToDouble() == value ? 0
        : decimalPlaces);
  }
}
