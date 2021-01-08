import 'package:currency_converter/core/repositories/database/database.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class DateUtil {
  static String parseDateToString(DateTime date) {
    return formatDate(
        date, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]);
  }

  static DateTime parseStringToDate(String date) {
    try {
      return DateTime.parse(date);
    } catch (e) {
      return null;
    }
  }

  static bool checkIsValid({@required String date, @required int validHours}) {
    if (date == null) return false;

    Duration difference = parseStringToDate(date).difference(DateTime.now());

    int hours = (difference.inHours * -1);

    return validHours >= hours;
  }
}