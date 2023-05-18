import 'package:intl/intl.dart';

class MyDateUtils{
  static String formatTaskDate(DateTime dateTime){
    var formatter = DateFormat("yyyy MMM dd");
    return formatter.format(dateTime);
  }
}