import 'package:nowu/viewmodels/base_model.dart';

import 'package:nowu/locator.dart';
import 'package:nowu/services/faq_service.dart';

import 'package:nowu/models/FAQ.dart';

class FAQViewModel extends BaseModel {
  final FAQService _faqService = locator<FAQService>();

  List<FAQ>? get faqs => _faqService.faqs;

  void fetchFAQs() async {
    setBusy(true);
    await _faqService.fetchFAQs();
    setBusy(false);
    notifyListeners();
  }
}
