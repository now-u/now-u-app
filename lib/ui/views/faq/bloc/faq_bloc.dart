import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/services/faq_service.dart';

import 'faq_state.dart';

class FaqBloc extends Cubit<FaqState> {
  FAQService _faqService;

  FaqBloc({
    required FAQService faqService,
  })  : _faqService = faqService,
        super(const FaqState.initial());

  Future<void> getFaqs() async {
    try {
      final faqs = await _faqService.getFaqs();
      emit(
        FaqState.success(faqs: faqs),
      );
    } catch (_) {
      emit(
        const FaqState.failure(),
      );
    }
  }
}
