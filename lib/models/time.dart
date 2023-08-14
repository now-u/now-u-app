const List<Map> timeBrackets = [
  {'text': '1-5 mins', 'minTime': 0, 'maxTime': 5},
  {'text': '5-15 mins', 'minTime': 5, 'maxTime': 15},
  {'text': '15-30 mins', 'minTime': 15, 'maxTime': 30},
  {'text': '30-60 mins', 'minTime': 30, 'maxTime': 60},
  {'text': 'Few hours', 'minTime': 60, 'maxTime': 240},
  {'text': 'Long term', 'minTime': 240, 'maxTime': double.infinity},
];

String getTimeText(int time) {
  return timeBrackets.firstWhere((b) => b['maxTime'] > time)['text'];
}

bool isNewDate(DateTime releaseAt) {
  return DateTime.now()
          .difference(releaseAt)
          .compareTo(const Duration(days: 2)) <
      0;
}
