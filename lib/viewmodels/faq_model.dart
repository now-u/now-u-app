import 'package:app/viewmodels/base_model.dart';

import 'package:app/locator.dart';
import 'package:app/services/faq_service.dart';

import 'package:app/models/FAQ.dart';

class FAQViewModel extends BaseModel {
  final FAQService _faqService = locator<FAQService>();

  List<FAQ> get faqs => _faqService.faqs;

  void fetchFAQs() async {
    setBusy(true);
    await _faqService.fetchFAQs();
    setBusy(false);
    notifyListeners();
  }
}
