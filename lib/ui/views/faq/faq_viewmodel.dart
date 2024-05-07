import 'package:causeApiClient/causeApiClient.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/services/faq_service.dart';

import 'package:stacked/stacked.dart';

class FaqViewModel extends FutureViewModel<List<Faq>> {
  final FAQService _faqService = locator<FAQService>();

  @override
  Future<List<Faq>> futureToRun() => _faqService.getFaqs();
}
