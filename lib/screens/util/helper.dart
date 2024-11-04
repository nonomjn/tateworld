import 'package:intl/intl.dart';

String formatDateTimeForPocketBase(DateTime dateTime) {
  final DateFormat formatter = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'");
  return formatter.format(dateTime.toUtc());
}

class Helper {
  static String formatNumber(int number) {
    if (number < 1000) {
      return number.toString();
    } else if (number < 1000000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    } else {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    }
  }
}
