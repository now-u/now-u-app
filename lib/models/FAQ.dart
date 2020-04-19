class FAQ {
  int _id;
  String _question;
  String _answer;
  bool _selected = false;

  FAQ({id, question, answer}) {
    _id = id; 
    _question = question;
    _answer = answer;
  }

  int getId() {
    return _id; 
  }
  String getQuestion() {
    return _question; 
  }
  String getAnswer() {
    return _answer; 
  }
  bool getSelected() {
    return _selected; 
  }
  void setSelected(bool selected) {
    _selected = selected; 
  }
}
