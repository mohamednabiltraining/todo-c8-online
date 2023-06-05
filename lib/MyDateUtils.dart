import 'package:intl/intl.dart';

class MyDateUtils{
  static String formatTaskDate(DateTime dateTime){
    var formatter = DateFormat("yyyy MMM dd");
    return formatter.format(dateTime);
  }
  static DateTime dateOnly(DateTime input){
    // return date only
    return DateTime(
      input.year,
      input.month,
      input.day
    );
  }
}
