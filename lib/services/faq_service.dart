import 'package:app/assets/constants.dart';
import 'package:app/models/FAQ.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class FAQService {
  List<FAQ>? _faqs = [];
  List<FAQ>? get faqs {
    return _faqs;
  }

  Future fetchFAQs() async {
    try {
      var response = await http.get(Uri.parse(CAUSES_API_URL + "faqs"));
      if (response.statusCode != 200) {
        return false;
      }
      _faqs = json
          .decode(response.body)['data']
          .map((e) => FAQ.fromJson(e))
          .toList()
          .cast<FAQ>();
    } catch (e) {
      return e.toString();
    }
  }
}
