import 'package:app/models/FAQ.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class FAQService {
  String domainPrefix = "https://api.now-u.com/api/v1/";

  List<FAQ> _faqs = [];
  List<FAQ> get faqs {
    return _faqs;
  }

  Future fetchFAQs() async {
    try {
      var response = await http.get(domainPrefix + "faqs");
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
