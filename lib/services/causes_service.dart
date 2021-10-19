import 'package:app/services/api_service.dart';
import 'package:app/models/Cause.dart';

class CausesService extends ApiService {
  Future<List<Cause>> getCauses(int id) async {
    Map response = await getRequest("causes");
    List<Map> causesData = response["data"] as List;
    List<Cause> causes = causesData.map((causeData) => Cause.fromJson(causeData));
    return causes;
  }
}
