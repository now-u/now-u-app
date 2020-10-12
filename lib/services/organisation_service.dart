import 'package:app/models/Organisation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrganisationService {
  
  String domainPrefix = "https://api.now-u.com/api/v1/";
 
  // This gets all the partners (for now this is just all the organisations)
  Future<List<Organisation>> getPartners() async {
    try {
      var response = await http.get(domainPrefix + "organisations");
      if (response.statusCode == 200) {
        List<Organisation> c = json
            .decode(response.body)['data']
            .map((e) => Organisation.fromJson(e))
            .toList()
            .cast<Organisation>();
        return c;
      }
      return [];
    } catch(e) {
      return [];
    }
  }
  
  Future<Organisation> getOrganisation(int id) async {
    try {
      print("Getting org");
      var response = await http.get(domainPrefix + "organisations/$id");
      if (response.statusCode == 200) {
        Organisation org = Organisation.fromJson(json.decode(response.body)['data']);
        return org;
      }
      return null;
    } catch(e) {
      return null;
    }
  }

}
