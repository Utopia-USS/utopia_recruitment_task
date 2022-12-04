import 'package:intl/intl.dart';

class DateTimeHelper {
  static String fullDate(DateTime dateTime) =>
      DateFormat('dd.MM.yyyy HH:mm').format(dateTime);

  static String dateOnly(DateTime dateTime) =>
      DateFormat('dd.MM.yyyy').format(dateTime);
}

extension DateTimeFormater on DateTime {
  DateTime utcToLocal() =>
      add(Duration(hours: DateTime.now().timeZoneOffset.inHours));
}
