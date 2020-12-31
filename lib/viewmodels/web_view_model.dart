import 'package:app/viewmodels/base_model.dart';

import 'package:app/locator.dart';
import 'package:app/services/navigation_service.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void onWebError(String url) {
    _navigationService.launchLink(url,
        isExternal: true,
        title: "Web error",
        description:
            "There has been an error loading the webpage would you like to try in your browser?");
  }
}
