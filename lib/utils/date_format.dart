class DateFormat {
  String simplyFormat({required DateTime time, bool dateOnly = false}) {
    String year = time.year.toString();

    String month = time.month.toString().padLeft(2, '0');

    String day = time.day.toString().padLeft(2, '0');

    String hour = time.hour.toString().padLeft(2, '0');

    String minute = time.minute.toString().padLeft(2, '0');

    String second = time.second.toString();

    if (dateOnly == false) {
      return "$year-$month-$day $hour:$minute:$second";
    }

    return '$day/$month/$year';
  }
}
