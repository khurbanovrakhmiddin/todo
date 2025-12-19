import 'package:intl/intl.dart';

class TimeParser {
  static String time(DateTime time, String? local) {
    return DateFormat('d MMMM, HH:mm', local).format(time);
  }
}
