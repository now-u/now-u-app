import 'package:flutter/material.dart';

import 'package:app/models/Quiz.dart';

class QuizPage extends StatefulWidget {

  final Quiz quiz;  

  QuizPage(this.quiz);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  Question currentQuestion;
  int currentQuestionIndex;
  int score;

  @override
  void initState() {
    score = 0;
    currentQuestionIndex = 1;
    currentQuestion = widget.quiz.questions[currentQuestionIndex - 1];
    super.initState();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Question ${currentQuestion}"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Center(
              child: Text(currentQuestion.getQuestion()),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Text(currentQuestion.getAnswers()[index].getAnswer());
              },     
            ),
          ),
        ],
      ),
    );
  }
}
