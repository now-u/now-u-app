import 'package:causeApiClient/api.dart';

class CausesService {
	void test() {
		final apiClient = ApiClient(basePath: "http://localhost:8000");
		CausesApi causeApi = CausesApi(apiClient);
		causeApi.listCauses();
		causeApi.retrieveCause("abc");
	}
}
