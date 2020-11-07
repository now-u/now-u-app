import 'package:flutter/material.dart';
import 'package:app/models/Quiz.dart';

class QuizCompletedPageArgumnets {
  final int score;
  final int numberOfQuestion;
  final Quiz quiz;
  
  QuizCompletedPageArgumnets({
    @required this.score, 
    @required this.numberOfQuestion, 
    @required this.quiz
  });
}

class QuizCompletedPage extends StatelessWidget {
  final QuizCompletedPageArgumnets args;
  QuizCompletedPage(this.args);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("You got ${args.score} / ${args.numberOfQuestion} in the ${args.quiz.title} quiz"),
      ),
    );
  }
}
