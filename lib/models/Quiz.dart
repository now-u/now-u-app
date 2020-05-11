import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class Quiz {
   
  int id;
  String title;
  String description;
  List<Question> questions;
  
  Quiz.fromJson(Map json) {
    print("Id is");
    print(json['id']);
    print("Title");
    print(json['title']);

    id = json['id'];
    title = json['title'];
    description = json['description'];
    print("questions");
    print(json['questions']);
    questions = (json['questions']).map((e) => Question.fromJson(e)).toList().cast<Question>();
  }

  int getId() {
    return id;
  }

  String getTitle() {
    return title;
  }

  List<Question> getQuestions() {
    return questions;
  }

}

Future<Quiz> readQuizFromAssets(int id) async {
  print("Getting quiz");
  var data = await rootBundle.loadString('assets/json/quiz.json');
  print("Got string");
  print(data);
  List<Quiz> quizes = (jsonDecode(data) as List).map((q) {
    print("The quiz");
    print(q);
    return Quiz.fromJson(q);
  }).toList().cast<Quiz>();
  print("Got quizes");
  Quiz quiz = quizes.where((q) => q.getId() == id).first;
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

class Question {
  String question;
  List<Answer> answers;

  Question.fromJson(Map json) {
    question = json['question'];
    answers = (json['answers']).map((e) => Answer.fromJson(e)).toList().cast<Answer>();
  }

  String getQuestion() {
    return question;
  }

  List<Answer> getAnswers() {
    return answers;
  }
}

class Answer {
  String answer;
  bool isCorrect;
  
  Answer.fromJson(Map json) {
    answer = json['answer'];
    isCorrect = json['isCorrect'];
  }

  String getAnswer() {
    return answer;
  }

  bool getIsCorrect() {
    return isCorrect;
  }
}

