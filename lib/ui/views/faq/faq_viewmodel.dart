import 'package:nowu/app/app.locator.dart';
import 'package:nowu/models/FAQ.dart';
import 'package:nowu/services/faq_service.dart';

import 'package:stacked/stacked.dart';

class FAQViewModel extends FutureViewModel<Iterable<FAQ>> {
  final FAQService _faqService = locator<FAQService>();

  @override
  Future<Iterable<FAQ>> futureToRun() => _faqService.fetchFAQs();
}
