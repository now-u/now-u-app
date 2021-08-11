import 'package:app/viewmodels/base_model.dart';
import 'package:app/locator.dart';
import 'package:app/services/navigation_service.dart';

class WebViewViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final String initialUrl;
  WebViewViewModel(this.initialUrl);

  void onWebError() {
    _navigationService.launchLink(initialUrl,
        isExternal: true,
        title: "Web error",
        description:
            "There has been an error loading the webpage would you like to try in your browser?");
  }

  void launchExternal() {
    _navigationService.launchLink(initialUrl,
        isExternal: true,
        title: 'Open with an External Browser?',
        description:
            'You are about to open this link with an external browser.',
        buttonText: 'Yes, Go Ahead',
        closeButtonText: 'Stay Here');
  }
}
