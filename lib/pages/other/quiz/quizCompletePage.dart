import 'package:flutter/material.dart';

class CompletedQuizPage extends StatelessWidget {
  final int score;
  final int numberOfQuestion;

  CompletedQuizPage(this.score, this.numberOfQuestion);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("${score} / ${numberOfQuestion}"),
      ),
    );
  }
}
