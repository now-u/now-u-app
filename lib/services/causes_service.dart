import 'package:app/services/api_service.dart';
import 'package:app/models/Cause.dart';

class CausesService extends ApiService {
  Future<List<ListCause>> getCauses() async {
    print("Making request");
    Map response = await getRequest("causes");
    List causesData = response["data"];
    List<ListCause> causes = causesData.map((causeData) => ListCause.fromJson(causeData)).toList();
    return causes;
  }
}
