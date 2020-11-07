import 'package:flutter/material.dart';
import 'dart:async';

import 'package:app/models/Quiz.dart';

import 'package:stacked/stacked.dart';
import 'package:app/viewmodels/quiz_view_model.dart';

class QuizPage extends StatelessWidget{
  final Quiz quiz;
  QuizPage(this.quiz);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ViewModelBuilder<QuizViewModel>.reactive(
            viewModelBuilder: () => QuizViewModel(),
            onModelReady: (model) {
              print(quiz);
              model.setQuiz = quiz;
              print("Here we go");
            },
            builder: (context, model, child) {
              return Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Center(
                        child: Text(model.currentQuestion.question),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                          itemCount: model.numberOfAnswers,
                          itemBuilder: (BuildContext context, int index) {
                            Color c = (index == model.selectedAnswerIndex)
                                ? (model.selectedAnswerIsCorrect)
                                    ? Colors.green
                                    : Colors.red
                                : Colors.grey;
                            return AnswerTile(model.currentQuestion.answers[index],
                                color: c, 
                                onClick: (Answer answer) {
                                  model.answerQuestion(answer, index);
                                  Timer(Duration(seconds: 1), () {
                                    model.nextQuestion();
                                  });
                                });
                          },
                        ),
                      ),
                    )
                  ],
                );
          }
        )
    );
  }
}

class AnswerTile extends StatelessWidget {
  final Answer answer;
  final Color color;
  final Function onClick;

  AnswerTile(this.answer, {@required this.color, @required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                onClick(answer);
              },
              child: Container(
                  color: color,
                  child: Center(
                    child: Text(answer.answerText),
                  )),
            )));
  }
}
