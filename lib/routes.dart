import 'package:flutter/material.dart';

import 'package:app/assets/routes/customRoute.dart';
import 'package:app/main.dart';

import 'package:app/pages/profile/profilePages/FAQPage.dart';
import 'package:app/pages/profile/profilePages/ProfilePage.dart';
import 'package:app/pages/profile/profilePages/PartnersPage.dart';


class Routes {
  static final home = "home";
  static final intro = "intro";
  static final login = "login";

  static const profile = "profile";
  static const faq = "faq";
  static const parteners = "parteners";
//  static final authEmailSent = "authEmailSent";
}

Function initRoutes =
  (RouteSettings settings) {
    switch (settings.name) {
      case Routes.profile: {
        return CustomRoute(
          builder: (context) => ProfilePage()
        );
      }
      case Routes.faq: {
        return CustomRoute(
          builder: (context) => FAQPage()
        );
      }
      case Routes.parteners: {
        return CustomRoute(
          builder: (context) => PartnersPage()
        );
      }
      // TODO add a 404 page
      default: {
        return CustomRoute(
          builder: (context) => MyHomePage(3)
        );
      }
    }
  };
