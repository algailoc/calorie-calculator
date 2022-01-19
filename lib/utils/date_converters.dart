DateTime stringToDate(String date) {
  var parts = date.split('.');
  return DateTime(
      int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
}

String dateToString(DateTime date) {
  return '${date.day}.${date.month}.${date.year}';
}

String mapWeekDayToString(int x) {
  switch (x) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thursday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    case 7:
      return 'Sunday';

    default:
      return '';
  }
}
