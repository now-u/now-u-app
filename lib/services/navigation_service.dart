import 'package:flutter/material.dart' hide Action;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/dialog_service.dart';
import 'package:url_launcher/url_launcher.dart';

const String INTERNAL_PREFIX = 'internal:';

class UrlLauncher {
  Future<void> openUrl(Uri url) async {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}

class CustomChromeSafariBrowser extends ChromeSafariBrowser {
  @override
  void onOpened() {
    print('ChromeSafari browser opened');
  }

  @override
  void onClosed() {
    print('ChromeSafari browser closed');
  }
}

// TODO Start to use router service
class NavigationService {
  final DialogService _dialogService = locator<DialogService>();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final UrlLauncher urlLauncher = UrlLauncher();
  final ChromeSafariBrowser browser = CustomChromeSafariBrowser();

  // TODO Work out why I was taking these in?
  // NavigationService(this.navigatorKey, this.urlLauncher, this.browser);

  @Deprecated('Use router service instead')
  Future<dynamic> navigateTo(
    String routeName, {
    arguments,
    clearHistory = false,
  }) {
    if (clearHistory) {
      return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName,
        (route) => false,
        arguments: arguments,
      );
    }
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  void goBack() {
    navigatorKey.currentState!.maybePop();
  }

  bool canGoBack() {
    return navigatorKey.currentState?.canPop() ?? false;
  }

  bool isInternalLink(String link) {
    return link.startsWith(INTERNAL_PREFIX);
  }

  bool isPDF(String link) {
    return link.endsWith('.pdf');
  }

  bool isInsecureLink(String link) {
    return link.startsWith('http://');
  }

  bool isMailTo(String link) {
    return link.startsWith('mailto:');
  }

  Map? getInternalLinkParameters(String url) {
    String link = url.substring(INTERNAL_PREFIX.length);

    if (!link.contains('&')) return null;

    Map parametersMap = {};
    String linkParameters = link.split('&')[1];
    List parameters = linkParameters.split('?');
    for (final param in parameters) {
      List splitParameter = param.split('=');
      String key = splitParameter[0];
      String value = splitParameter[1];
      parametersMap[key] = value;
    }
    return parametersMap;
  }

  getInternalLinkRoute(String url) {
    String link = url.substring(INTERNAL_PREFIX.length);
    if (link.contains('&')) {
      return link.split('&')[0];
    } else {
      return link;
    }
  }

  // TODO Move link navigation outside of this service
  Future launchLink(
    String url, {
    String? title,
    String? description,
    String? buttonText,
    String? closeButtonText,
    Function? extraOnConfirmFunction,
    bool? isExternal,
  }) async {
    // final CausesService _causesService = locator<CausesService>();
    // if (isInternalLink(url)) {
    //   String route = getInternalLinkRoute(url);
    //   Map? parameters = getInternalLinkParameters(url);

    //   if (ID_ROUTES.contains(route)) {
    //     int? id = int.tryParse(parameters!['id']);

    //     if (route == Routes.campaignInfo) {
    //       navigateTo(route, arguments: id);
    //       return;
    //     }

    //     if (route == Routes.actionInfo) {
    //       if (id == null) {
    //         navigateTo(Routes.explore);
    //         return;
    //       }
    //       _causesService.getAction(id).then((Action action) {
    //         navigateTo(route, arguments: action);
    //       }).catchError((e) {
    //         _dialogService.showErrorDialog(
    //           title: 'Error',
    //           description: 'Error navigating to route',
    //         );
    //       });
    //       return;
    //     }
    //   }

    //   navigateTo(route);
    // } else if ((isExternal ?? false) || isMailTo(url)) {
    if ((isExternal ?? false) || isMailTo(url)) {
      await launchLinkExternal(
        url,
        title: title,
        description: description,
        buttonText: buttonText,
        closeButtonText: closeButtonText,
        extraOnConfirmFunction: extraOnConfirmFunction,
      );
    } else {
      if (extraOnConfirmFunction != null) extraOnConfirmFunction();
      await browser.open(
        url: Uri.parse(url),
      );
    }
  }

  Future<void> launchLinkExternal(
    String url, {
    String? title,
    String? description,
    String? buttonText,
    String? closeButtonText,
    Function? extraOnConfirmFunction,
  }) async {
    bool shouldExit = await _dialogService.showExitConfirmationDialog();
    if (shouldExit) {
      if (extraOnConfirmFunction != null) {
        extraOnConfirmFunction();
      }
      await urlLauncher.openUrl(Uri.parse(url));
    }
  }

  void launchPDF() {}
}
