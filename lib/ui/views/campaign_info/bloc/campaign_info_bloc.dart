import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/services/causes_service.dart';

import './campaign_info_state.dart';

class CampaignInfoBloc extends Cubit<CampaignInfoState> {
  CausesService _causesService;

  CampaignInfoBloc({
    required causesService,
  })  : _causesService = causesService,
        super(const CampaignInfoState.initial());

  Future<void> fetchCampaign(int campaignId) async {
    final campaign = await _causesService.getCampaign(campaignId);
    emit(CampaignInfoState.success(campaign: campaign));
  }
}
