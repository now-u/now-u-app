import 'package:nowu/assets/constants.dart';
import 'package:nowu/models/FAQ.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class FAQService {
  // TODO Add FAQ to api v2 and fetch here
  Future<Iterable<FAQ>> fetchFAQs() async {
    var response = await http.get(getCausesApiPath('v1/faqs'));
    if (response.statusCode != 200) {
      throw Exception('Error whilst fetching FAQs');
    }
    return json
        .decode(response.body)['data']
        .map((e) => FAQ.fromJson(e))
        .cast<FAQ>();
  }
}
