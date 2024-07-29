import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nowu/models/faq.dart';

part 'faq_state.freezed.dart';

@freezed
sealed class FaqState with _$FaqState {
  const factory FaqState.initial() = FaqStateInitial;
  const factory FaqState.failure() = FaqStateFailure;
  const factory FaqState.success({
    @Default([]) List<Faq> faqs,
  }) = FaqStateSuccess;
}
