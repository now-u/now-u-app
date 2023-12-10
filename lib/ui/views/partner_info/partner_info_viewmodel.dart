import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

class PartnerInfoViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  void launchLink(String url) {
    _navigationService.launchLink(url, isExternal: true);
  }
}
