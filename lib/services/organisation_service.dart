import 'package:app/locator.dart';
import 'package:app/services/api_service.dart';
import 'package:app/models/Organisation.dart';

class OrganisationService {
  final ApiService _apiService = locator<ApiService>();

  // This gets all the partners (for now this is just all the organisations)
  Future<List<Organisation>> getPartners() async {
    return _apiService.getModelListRequest(
        "v1/organisations", Organisation.fromJson);
  }
}
