import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeFormatter {

  static String birthDate(DateTime value) {
    return DateFormat('yyyy-MM-dd').format(value).toString();
  }

  static String sendTime(value) {
    return DateFormat("HH:mm:ss").format(DateFormat.Hm().parse(value));
  }

  static String chatTime(value) {
    return DateFormat("hh:mm a").format(value);
  }

}
