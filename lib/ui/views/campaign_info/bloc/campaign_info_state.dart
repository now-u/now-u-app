import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nowu/models/Campaign.dart';

part 'campaign_info_state.freezed.dart';

@freezed
sealed class CampaignInfoState with _$CampaignInfoState {
  const factory CampaignInfoState.initial() = CampaignInfoStateInitial;
  const factory CampaignInfoState.failure() = CampaignInfoStateFailure;
  const factory CampaignInfoState.success({
    Campaign campaign,
  }) = CampaignInfoStateSuccess;
}
