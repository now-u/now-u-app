import 'package:causeApiClient/causeApiClient.dart';
import 'package:nowu/app/app.locator.dart';

import 'package:nowu/services/api_service.dart';

class FAQService {
  final _apiService = locator<ApiService>();
  CauseApiClient get _causeServiceClient => _apiService.apiClient;

  Future<List<Faq>> getFaqs() async {
    final response = await _causeServiceClient.getFaqsApi().faqsList();
    return response.data!.toList();
  }
}
