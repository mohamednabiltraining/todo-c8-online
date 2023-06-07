import 'package:intl/intl.dart';

class MyDateUtils{
  static String formatTaskDate(DateTime dateTime){
    var formatter = DateFormat("yyyy MMM dd");
    return formatter.format(dateTime);
  }
  static DateTime getDateOnly(DateTime dateTime){
    return DateTime(dateTime.year,
    dateTime.month,
    dateTime.day,);
  }
}
