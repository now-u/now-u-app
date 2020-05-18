class FAQ {
  // TODO add category to FAQs
  int id;
  String question;
  String answer;
  bool selected = false;

  FAQ({this.id, this.question, this.answer});
  
  FAQ.fromJson(Map json) {
    id         = json['id'];
    question   = json['answer'];
    answer     = json['question'];
  }

  int getId() {
    return id; 
  }
  String getQuestion() {
    return question; 
  }
  String getAnswer() {
    return answer; 
  }
  bool getSelected() {
    return selected; 
  }
  void setSelected(bool selected) {
    selected = selected; 
  }
}
