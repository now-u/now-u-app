class FAQ {
  int _id;
  int get id => _id;

  String _question;
  String get question => _question;

  String _answer;
  String get answer => _answer;

  FAQ.fromJson(Map json) :
    _id = json['id'],
    _question = json['question'],
    _answer = json['answer'];
}
