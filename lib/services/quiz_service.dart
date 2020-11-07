import 'package:app/models/Quiz.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class QuizService {
  
  String domainPrefix = "https://stagingapi.now-u.com/api/v1/";
  
  Future<Quiz> getQuiz(int quizId) async {
    try {
      http.Response response = await http
          .get(domainPrefix + "quizzes/$quizId");
      if (response.statusCode == 200) {
        Map jsonData = json.decode(response.body)["data"];
        return Quiz.fromJson(jsonData);
      } else {
        return Future.error("Error");
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

}
