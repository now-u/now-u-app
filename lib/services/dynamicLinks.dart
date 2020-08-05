import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'package:app/locator.dart';
import 'package:app/services/navigation.dart';
import 'package:app/services/storage.dart';

import 'package:app/pages/login/emailSentPage.dart';

import 'package:app/routes.dart';

import 'package:meta/meta.dart';
    
// The holy grail link https://nowu.page.link/?link=https://now-u.com/campaigns?id=1&apn=com.nowu.app

class DynamicLinkService {
  
  final NavigationService _navigationService = locator<NavigationService>();
  final SecureStorageService _storageProvider = locator<SecureStorageService>();

  Future handleDynamicLinks() async {
    // 1. Get the initial dynamic link if the app is opened with a dynamic link
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
  
    // 2. handle link that has been retrieved
    _handleDeepLink(data);
  
    // 3. Register a link callback to fire if the app is opened up from the background
    // using a dynamic link.
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      // 3a. handle link that has been retrieved
      _handleDeepLink(dynamicLink);
    }, onError: (OnLinkErrorException e) async {
      print('Link Failed: ${e.message}');
    });
  }

  void _handleDeepLink(PendingDynamicLinkData data) async {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      print('_handleDeepLink | deeplink: $deepLink');
      print('_handleDeepLink | deepLink path: ${deepLink.path}');
      if (deepLink.path == "/loginMobile") {
        String email = await _storageProvider.getEmail();
        String token = deepLink.queryParameters['token'];
        EmailSentPageArguments args = EmailSentPageArguments(email: email, token: token);
        print("Navigating to emailSent");
        _navigationService.navigateTo(Routes.loginLinkClicked, arguments: args);
      }
      if (RegExp('campaigns/[0-9]+').hasMatch(deepLink.path)) {
        String campaignNumberString = deepLink.path.substring(11);
        print("_handleDeepLink | campaign number: $campaignNumberString");
        int campaignNumber = int.parse(campaignNumberString);
        _navigationService.navigateTo(Routes.campaignInfo, arguments: campaignNumber);
      }
    }
    else {
      print("Deep link was null");
    }
  }

  Future<Uri> getLink() async {
    PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    print("Data is");
    print(data);
    return data?.link;
  }

  // Dynamic Links setup
  Future <Uri> createDynamicLink(
    {
      @required String linkPath,
      @required String title,
      @required String description, 
      @required String imageUrl,
      bool short,
    }
  ) async {
    print("Getting uri");
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: "https://nowu.page.link",
      link: Uri.parse("https://now-u.com/${linkPath}"),
      androidParameters: AndroidParameters(
        packageName: "com.nowu.app",
        minimumVersion: 0,
      ),
      //TODO IOS needs fixing
      iosParameters: IosParameters(
        bundleId: "com.google.FirebaseCppDynamicLinksTestApp.dev",
        minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: title,
        description: description,
        imageUrl: Uri.parse(imageUrl),
      )
    );
    Uri url;
    if (short == false) {
      url = await parameters.buildUrl();
    }
    // Short is either null or true
    else {
      final ShortDynamicLink shortLink = await parameters.buildShortLink();
      print(shortLink.toString());
      url = shortLink.shortUrl;
    }
    return url;
  }

}

