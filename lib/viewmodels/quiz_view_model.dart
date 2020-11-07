import 'package:app/routes.dart';
import 'package:app/locator.dart';
import 'package:app/viewmodels/base_model.dart';

import 'package:app/services/navigation_service.dart';

import 'package:app/pages/other/quiz/quizCompletePage.dart'; 

import 'package:app/models/Quiz.dart';

class QuizViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Quiz _quiz;
  set setQuiz(Quiz q) => _quiz = q;

  int get numberOfQuestion => _quiz.questions.length;
  int _currentQuestionIndex = 0;
  Question get currentQuestion {
    return _quiz.questions[_currentQuestionIndex];
  }

  int score = 0;
  
  int _selectedAnswerIndex;
  int get selectedAnswerIndex => _selectedAnswerIndex;
  int get numberOfAnswers =>  currentQuestion.answers.length;
  bool get selectedAnswerIsCorrect {
    if (_selectedAnswerIndex != null) {
      return _quiz.questions[_currentQuestionIndex].answers[_selectedAnswerIndex].isCorrect;
    }
    else {
      return false;
    }
  } 
  
  void nextQuestion() {
    print("Getting next question");
    if (_currentQuestionIndex == _quiz.questions.length - 1) {
      QuizCompletedPageArgumnets args = QuizCompletedPageArgumnets(
        score: score,
        numberOfQuestion: numberOfQuestion,
        quiz: _quiz,
      );
      _navigationService.navigateTo(Routes.quizCompleted, arguments: args);
    } else {
      _selectedAnswerIndex = null;
      _currentQuestionIndex++;
    }
    notifyListeners();
  }
  
  void answerQuestion(Answer answer, int index) {
    _selectedAnswerIndex = index;
    if (answer.isCorrect) { 
      score++;
    }
    notifyListeners();
  }
}
