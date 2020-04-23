import 'package:app/models/Campaign.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/User.dart';

import 'package:app/models/State.dart';
import 'package:redux/redux.dart';
import 'package:app/redux/actions.dart';

class ViewModel {
  final List<Campaign> campaigns;
  final User user;
  final Function(User) onSelectCampaigns;
  final Function(CampaignAction) onCompleteAction;

  ViewModel({
    this.campaigns,
    this.user,
    this.onSelectCampaigns,
    this.onCompleteAction,
  });

  factory ViewModel.create(Store<AppState> store) {
    _onSelectCampaigns(User u) {
      store.dispatch(SelectCampaignsAction(u));
    }

    _onCompleteAction(CampaignAction action) {
      store.dispatch(CompleteAction(action));
    }

    return ViewModel(
      campaigns: store.state.campaigns,
      user: store.state.user,
      onSelectCampaigns: _onSelectCampaigns,
      onCompleteAction: _onCompleteAction,
    );
  }
}
