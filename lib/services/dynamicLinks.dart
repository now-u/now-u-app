import 'dart:async';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';

import 'package:nowu/locator.dart';
import 'package:nowu/services/storage.dart';

import 'package:uni_links/uni_links.dart';

// The holy grail link https://nowu.page.link/?link=https://now-u.com/campaigns?id=1&apn=com.nowu.app

class DynamicLinkService {
  final SecureStorageService _storageProvider = locator<SecureStorageService>();
  // TODO Remove/fix for web this service
  // final DeviceInfoService? _deviceInfoService = locator<DeviceInfoService>();

  Future handleDynamicLinks() async {
    bool gotIosLink = false;

    // TODO Find out which of these is required? I commented out below and replaced with this because device service is not available
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await initUniLinks();
    }
    // if (await _deviceInfoService!.isIOS13) {
    //   await initUniLinks();
    // }

    if (!gotIosLink) {
      // 1. Get the initial dynamic link if the app is opened with a dynamic link
      final PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();

      // 2. handle link that has been retrieved
      final Uri? deepLink = data?.link;
      _handleDeepLink(deepLink);
    }
    // 3. Register a link callback to fire if the app is opened up from the background
    // using a dynamic link.
    FirebaseDynamicLinks.instance.onLink.listen(
      (dynamicLinkData) {
        _handleDeepLink(dynamicLinkData.link);
      },
      onError: (e) async {
        print('Link Failed: ${e.message}');
      },
    );
  }

  void _handleDeepLink(Uri? deepLink) async {
    if (deepLink != null) {
      print('_handleDeepLink | deeplink: $deepLink');
      print('_handleDeepLink | deepLink path: ${deepLink.path}');
      if (deepLink.path == '/loginMobile' || deepLink.host == 'loginmobile') {
        String? email = await _storageProvider.getEmail();
        if (email == null) return;

        //. String? token = deepLink.queryParameters['token'];
        print('Navigating to emailSent');
        // TODO WTF is going on here? Do we need this and the supabase stuff
        // _routerService.navigateToLoginEmailSentView(email: email, token: token);
      }
      if (RegExp('campaigns/[0-9]+').hasMatch(deepLink.path)) {
        String campaignNumberString = deepLink.path.substring(11);
        print('_handleDeepLink | campaign number: $campaignNumberString');

        // TODO Handle this -> should this use link?? Look up how deep links work these days
        // int campaignNumber = int.parse(campaignNumberString);
        // _routerService.navigateToCampaignInfoView(arguments: campaignNumber);
      }
    } else {
      print('Deep link was null');
    }
  }

  Future<Uri?> getLink() async {
    PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    return data?.link;
  }

  // Dynamic Links setup
  Future<Uri> createDynamicLink({
    required String linkPath,
    required String title,
    required String description,
    required String imageUrl,
    bool? short,
  }) async {
    print('Getting uri');
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://nowu.page.link',
      link: Uri.parse('https://now-u.com/$linkPath'),
      androidParameters: const AndroidParameters(
        packageName: 'com.nowu.app',
        minimumVersion: 0,
      ),
      //TODO IOS needs fixing
      iosParameters: const IOSParameters(
        bundleId: 'com.google.FirebaseCppDynamicLinksTestApp.dev',
        minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: title,
        description: description,
        imageUrl: Uri.parse(imageUrl),
      ),
    );
    Uri url;
    if (short == false) {
      url = await FirebaseDynamicLinks.instance.buildLink(parameters);
    }
    // Short is either null or true
    else {
      final ShortDynamicLink shortLink =
          await FirebaseDynamicLinks.instance.buildShortLink(parameters);
      print(shortLink.toString());
      url = shortLink.shortUrl;
    }
    return url;
  }

  // Handling deeplinks
  // TODO: Don't forget to call _sub.cancel() in dispose()
  // StreamSubscription? _sub;

  Future<bool> initUniLinks() async {
    // Example deeplink
    // com.nowu.app://loginMobile?token=14087f13e394b73447607a8da3828056271d4fd789fd1dc6cf5f3ba4601836295dd319a0c5e69f64
    bool gotLink = false;

    // Attach a listener to the stream
    uriLinkStream.listen(
      (Uri? deepLink) {
        if (deepLink != null) {
          gotLink = true;
          _handleDeepLink(deepLink);
        }
      },
      onError: (err) {
        // Handle exception by warning the user their action did not succeed
        print('D| $err');
      },
    );
    // TODO: Don't forget to call _sub.cancel() in dispose()
    return gotLink;
  }
}
