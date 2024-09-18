const List<({String text, double minTime, double maxTime})> timeBrackets = [
  (text: '1-5 mins', minTime: 0, maxTime: 4.9),
  (text: '5-15 mins', minTime: 5, maxTime: 14.9),
  (text: '15-30 mins', minTime: 15, maxTime: 29.9),
  (text: '30-60 mins', minTime: 30, maxTime: 59.9),
  (text: 'Few hours', minTime: 60, maxTime: 239.9),
  (text: 'Long term', minTime: 240, maxTime: double.infinity),
];

String getTimeText(int time) {
  return timeBrackets.firstWhere((b) => b.maxTime > time).text;
}

bool isNewDate(DateTime releaseAt) {
  return DateTime.now()
          .difference(releaseAt)
          .compareTo(const Duration(days: 2)) <
      0;
}
