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
      var response = await http.get(getCausesApiPath("v1/faqs"));
      if (response.statusCode != 200) {
        print("Error whilst fetching FAQs");
        return false;
      }
      _faqs = json
          .decode(response.body)['data']
          .map((e) => FAQ.fromJson(e))
          .toList()
          .cast<FAQ>();
    } catch (e) {
      print("Failed to fetch faqs");
      print(e);
      return e.toString();
    }
  }
}
