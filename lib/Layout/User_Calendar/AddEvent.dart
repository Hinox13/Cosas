addEvent(DateTime date, String name, Map<DateTime, List> events) {
  if (events.containsKey(date)) {
    events[date].add(name);
  } else {
    events[date] = [name];
  }
}

DateTime today() {
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}
