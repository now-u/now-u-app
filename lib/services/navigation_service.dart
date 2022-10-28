import 'package:app/services/causes_service.dart';
import 'package:flutter/material.dart';
import 'package:app/routes.dart';

import 'package:app/locator.dart';
import 'package:app/services/dialog_service.dart';

import 'package:app/assets/components/buttons/darkButton.dart';
import 'package:app/models/Action.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

const String INTERNAL_PREFIX = "internal:";

const List ID_ROUTES = [Routes.campaignInfo, Routes.actionInfo];

class UrlLauncher {
  void openUrl(Uri url) {
    launchUrl(url);
  }
}

class CustomChromeSafariBrowser extends ChromeSafariBrowser {
  @override
  void onOpened() {
    print("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad() {
    print("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    print("ChromeSafari browser closed");
  }
}

class NavigationService {
  final DialogService _dialogService = locator<DialogService>();
  final CausesService _causesService = locator<CausesService>();
  final ChromeSafariBrowser _browser = new CustomChromeSafariBrowser();

  final GlobalKey<NavigatorState> navigatorKey;
  final UrlLauncher urlLauncher;
  NavigationService(this.navigatorKey, this.urlLauncher);

  Future<dynamic> navigateTo(String routeName, {arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }

  bool isInternalLink(String link) {
    return link.startsWith(INTERNAL_PREFIX);
  }

  bool isPDF(String link) {
    return link.endsWith(".pdf");
  }

  bool isInsecureLink(String link) {
    return link.startsWith("http://");
  }

  bool isMailTo(String link) {
    return link.startsWith("mailto:");
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

  Future launchLink(
    String url, {
    String? title,
    String? description,
    String? buttonText,
    String? closeButtonText,
    Function? extraOnConfirmFunction,
    bool? isExternal,
  }) async {
    if (isInternalLink(url)) {
      String route = getInternalLinkRoute(url);
      Map? parameters = getInternalLinkParameters(url);

      if (ID_ROUTES.contains(route)) {
        int? id = int.tryParse(parameters!['id']);

        if (route == Routes.campaignInfo) {
          navigateTo(route, arguments: id);
          return;
        }

        if (route == Routes.actionInfo) {
          if (id == null) {
            navigateTo(Routes.explore);
            return;
          }
          _causesService.getAction(id).then((CampaignAction action) {
            navigateTo(route, arguments: action);
          }).catchError((e) {
            _dialogService.showDialog(BasicDialog(
                title: "Error", description: "Error navigating to route"));
          });
          return;
        }
      }

      navigateTo(route);
    } else if ((isExternal ?? false) || isPDF(url) || isMailTo(url)) {
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
      await _browser.open(
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
    print("Launching external link");
    AlertResponse exit = await (_dialogService.showDialog(
      BasicDialog(
          title: title ?? "You're about to leave",
          description: description ??
              "This link will take you out of the app. Are you sure you want to go?",
          buttons: <DialogButton>[
            DialogButton(
              text: buttonText ?? "Let's go",
              response: true,
            ),
            DialogButton(
              text: closeButtonText ?? "Close",
              response: false,
              style: DarkButtonStyle.Secondary,
            ),
          ]),
    ) as Future<AlertResponse>);
    print("Exit response is: ${exit.response}");
    if (exit.response) {
      if (extraOnConfirmFunction != null) {
        extraOnConfirmFunction();
      }
      print("Calling url launcher");
      urlLauncher.openUrl(Uri.parse(url));
    }
  }

  void launchPDF() {}
}
