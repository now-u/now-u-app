class FAQ {
  final int id;
  final String question;
  final String answer;

  FAQ.fromJson(Map json)
      : id = json['id'],
        question = json['question'],
        answer = json['answer'];
}
