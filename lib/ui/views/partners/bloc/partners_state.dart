import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nowu/models/organisation.dart';

part 'partners_state.freezed.dart';

@freezed
sealed class PartnersState with _$PartnersState {
  const factory PartnersState.initial() = PartnersStateInitial;
  const factory PartnersState.failure() = PartnersStateFailure;
  const factory PartnersState.success({
    @Default([]) List<Organisation> partners,
  }) = PartnersStateSuccess;
}
