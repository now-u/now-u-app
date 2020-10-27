import 'package:flutter/material.dart';
import 'package:app/routes.dart';

import 'package:app/locator.dart';
import 'package:app/services/dialog_service.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:app/assets/components/darkButton.dart';

const String INTERNAL_PREFIX = "internal:";

class NavigationService {
  final DialogService _dialogService =
      locator<DialogService>();

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  
  Future<dynamic> navigateTo(String routeName, {arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }


  bool isInternalLink(String link) {
    return link.startsWith(INTERNAL_PREFIX);
  }
  
  Map getInternalLinkParameters(String link) {
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


  void launchLink(
    String url, {
    String title,
    String description,
    String buttonText,
    String closeButtonText,
    Function extraOnConfirmFunction,
    bool isExternal,
  }) {
    if (isInternalLink(url)) {
      String link = url.substring(INTERNAL_PREFIX.length);
  
      if(url.contains('&')) {
        Map parameters = getInternalLinkParameters(link);
        String route = link.split('&')[0];
  
        if (parameters['id'] != null) {
          navigateTo(route, arguments: parameters['id']);
        } else {
          navigateTo(route);
        }
      } else {
        navigateTo(link);
      }
    } else if (isExternal ?? false) {
      launchLinkExternal(
        url,
        title: title,
        description: description,
        buttonText: buttonText,
        closeButtonText: closeButtonText,
        extraOnConfirmFunction: extraOnConfirmFunction,
      );
    } else {
      if (extraOnConfirmFunction != null) extraOnConfirmFunction();
      navigateTo(Routes.webview, arguments: url);
    }
  }

  void launchLinkExternal(
    String url, {
    String title,
    String description,
    String buttonText,
    String closeButtonText,
    Function extraOnConfirmFunction,
  }) async {
    AlertResponse exit = await _dialogService.showDialog(
      title: title ?? "You're about to leave",
      description:  description ?? "This link will take you out of the app. Are you sure you want to go?",
      buttons: [
        DialogButton(
          text: "Let's go",
          response: true,
        ),
        DialogButton(
          text: "Close",
          response: false,
          style: DarkButtonStyle.Secondary,
        ),
      ]
    );
    if (exit.response) {
      if (extraOnConfirmFunction != null) {
        extraOnConfirmFunction();
      }
      launch(url);
    }
  }
}
