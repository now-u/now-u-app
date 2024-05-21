import 'package:causeApiClient/causeApiClient.dart' as Api;
import 'package:nowu/locator.dart';
import 'package:nowu/models/faq.dart';

import 'package:nowu/services/api_service.dart';

class FAQService {
  final _apiService = locator<ApiService>();
  Api.CauseApiClient get _causeServiceClient => _apiService.apiClient;

  Future<List<Faq>> getFaqs() async {
    final response = await _causeServiceClient.getFaqsApi().faqsList();
    return response.data!.map((faq) => Faq(faq)).toList();
  }
}
