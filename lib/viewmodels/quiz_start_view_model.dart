import 'package:app/routes.dart';
import 'package:app/locator.dart';
import 'package:app/services/quiz_service.dart';
import 'package:app/services/navigation_service.dart';

import 'package:app/models/Quiz.dart';

class QuizViewModel {
  final QuizService _quizService = locator<QuizService>();
  Quiz _quiz;

  Future<Quiz> getQuiz(int id) async {
    if (_quiz == null) {
      _quiz = await _quizService.getQuiz(id);
      return _quiz;
    }
    return _quiz;
  }
}
