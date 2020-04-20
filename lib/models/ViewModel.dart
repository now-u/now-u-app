import 'package:app/models/Campaign.dart';
import 'package:app/models/User.dart';

import 'package:app/models/State.dart';
import 'package:redux/redux.dart';
import 'package:app/redux/actions.dart';

class ViewModel {
  final List<Campaign> campaigns;
  final User user;
  final Function(List<Campaign>) onSelectCampaigns;

  ViewModel({
    this.campaigns,
    this.user,
    this.onSelectCampaigns,
  });

  factory ViewModel.create(Store<AppState> store) {
    _onSelectCampaigns(List<Campaign> c) {
      store.dispatch(SelectCampaignsAction(c));
    }

    return ViewModel(
      campaigns: store.state.campaigns,
      user: store.state.user,
      onSelectCampaigns: _onSelectCampaigns,
    );
  }
}
