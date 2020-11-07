import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class Quiz {
  int _id;
  int get id => _id;

  String _title;
  String get title => _title;

  String _description;
  String get description => _description;

  List<Question> _questions;
  List<Question> get questions => _questions;

  Quiz.fromJson(Map json) {
    print("Id is");
    print(json['id']);
    print("Title");
    print(json['title']);

    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _questions = (json['questions'])
        .map((e) => Question.fromJson(e))
        .toList()
        .cast<Question>();
  }
}

class Question {
  String _question;
  String get question => _question;
  
  List<Answer> _answers;
  List<Answer> get answers => _answers;

  Question.fromJson(Map json) {
    _question = json['question'];
    _answers = (json['answers'])
        .map((e) => Answer.fromJson(e))
        .toList()
        .cast<Answer>();
  }
}

class Answer {
  String _answerImage;
  String get answerImage => _answerImage;

  String _answerText;
  String get answerText => _answerText;

  bool _isCorrect;
  bool get isCorrect => _isCorrect;

  Answer.fromJson(Map json) {
    _answerImage = json['answer_image_url'];
    _answerText = json['answer_text'];
    _isCorrect = json['is_correct'];
  }
}


Future<Quiz> readQuizFromAssets(int id) async {
  print("Getting quiz");
  var data = await rootBundle.loadString('assets/json/quiz.json');
  print("Got string");
  print(data);
  List<Quiz> quizes = (jsonDecode(data) as List)
      .map((q) {
        print("The quiz");
        print(q);
        return Quiz.fromJson(q);
      })
      .toList()
      .cast<Quiz>();
  print("Got quizes");
  Quiz quiz = quizes.where((q) => q.id == id).first;
  print(quiz);
  return quiz;
  //rootBundle.loadString('assets/json/quiz.json').then(
  //  (data) {
  //    print("The json string is " + data);
  //    print("Decoding");
  //    List<Quiz> quizes = (jsonDecode(data) as List).map((q) => Quiz.fromJson(q)).toList().cast<Quiz>();
  //    // TODO what happens when 0
  //    Quiz quiz = quizes.where((q) => q.getId() == id).first;
  //    print(quiz.getTitle());
  //    return quiz;
  //  }
  //);
}

