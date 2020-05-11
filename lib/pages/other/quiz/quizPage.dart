import 'package:flutter/material.dart';
import 'dart:async';

import 'package:app/models/Quiz.dart';

import 'package:app/pages/other/quiz/quizCompletePage.dart';

import 'package:app/assets/routes/customRoute.dart';

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
  int selectAnswerIndex;
  bool isCompleted;

  @override
  void initState() {
    score = 0;
    currentQuestionIndex = 0;
    currentQuestion = widget.quiz.getQuestions()[currentQuestionIndex];
    isCompleted = false;
    super.initState();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Question ${currentQuestion}"),
      ),
      body: 
      isCompleted ? 
      CompletedQuizPage(score, widget.quiz.getQuestions().length)
      :
      Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Center(
              child: Text(currentQuestion.getQuestion()),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  Color c = 
                    (index == selectAnswerIndex) ? 
                    (currentQuestion.getAnswers()[index].isCorrect) ? 
                    Colors.green : Colors.red
                    : Colors.grey;
                  return AnswerTile(
                      currentQuestion.getAnswers()[index], 
                      color: c,
                      onClick: (answer) {
                        print("Selected answer = " + (index).toString());
                        setState(() {
                          selectAnswerIndex = index;                          
                          if(currentQuestion.getAnswers()[index].getIsCorrect()) {
                            print("Increasing score");
                            score += 1;
                          }
                        });
                        Timer(Duration(seconds: 1), () {
                          currentQuestionIndex += 1;
                          if (currentQuestionIndex >= widget.quiz.getQuestions().length) {
                            setState(() {
                              isCompleted = true;
                            });
                          } 
                          else {
                            setState(() {
                              selectAnswerIndex = null;
                              currentQuestion = widget.quiz.getQuestions()[currentQuestionIndex];
                            });
                          }
                        });
                      }
                    );
                },     
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AnswerTile extends StatelessWidget {
  final Answer answer;
  final Color color;
  final Function onClick;

  AnswerTile(
    this.answer,
    {
    @required this.color,
    @required this.onClick
    }
  );

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      child: Padding( 
      padding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            onClick(answer);
          },
          child: Container(
            color: color,
            child: Center(
              child: Text(answer.getAnswer()),
            )
          ),
        )
      )
    );
  }
}
