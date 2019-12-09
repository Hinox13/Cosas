addEvent(DateTime date, String name, Map<DateTime, List> events) {
  if (events.containsKey(date)) {
    events[date].add(name);
  } else {
    events[date] = [name];
  }
  return events;
}
