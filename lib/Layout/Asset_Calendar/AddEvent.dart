addEvent(DateTime date, Map<String, dynamic> reserve, Map<DateTime, List> events) {
  print(date);
  if (events.containsKey(date)) {
    events[date].add(reserve);
  } else {
    events[date] = [reserve];
  }
}

DateTime today() {
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}
