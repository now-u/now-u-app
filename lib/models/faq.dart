import 'package:causeApiClient/causeApiClient.dart' as Api;

class Faq {
  final int id;
  final String question;
  final String answer;

  Faq(Api.Faq apiModel)
      : id = apiModel.id,
        question = apiModel.question,
        answer = apiModel.answer;
}
