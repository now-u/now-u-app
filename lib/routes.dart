import 'package:nowu/assets/routes/customRoute.dart';
import 'package:nowu/models/Campaign.dart';
import 'package:nowu/models/Notification.dart';
import 'package:nowu/models/Organisation.dart';
import 'package:nowu/pages/login/emailSentPage.dart';
import 'package:nowu/pages/login/login_code_view.dart';
import 'package:nowu/pages/more/morePages/AccountDetailsPage.dart';
import 'package:nowu/pages/other/InfoPage.dart';
import 'package:nowu/pages/other/NotificationPage.dart';
import 'package:nowu/pages/other/OrganisationPage.dart';
import 'package:flutter/material.dart';
import 'package:nowu/ui/views/action_info/action_info_view.dart';
import 'package:nowu/ui/views/campaign_info/campaign_info_view.dart';
import 'package:nowu/ui/views/causes_selection/change_view/change_select_causes_view.dart';
import 'package:nowu/ui/views/causes_selection/onboarding_view/onboarding_select_causes_view.dart';
import 'package:nowu/ui/views/explore/explore_page_definition.dart';
import 'package:nowu/ui/views/faq/faq_view.dart';
import 'package:nowu/ui/views/intro/intro_view.dart';
import 'package:nowu/ui/views/login/login_view.dart';
import 'package:nowu/ui/views/partners/partners_view.dart';
import 'package:nowu/ui/views/profile_setup/profile_setup_view.dart';
import 'package:nowu/ui/views/search/search_view.dart';
import 'package:nowu/ui/views/tabs/tabs_view.dart';

class Routes {
  // Intro
  static const onBoarding = 'onBoarding';
  static const intro = 'intro';
  static const login = 'login';
  static const emailSent = 'emailSent';
  static const loginCodeInput = 'loginCodeInput';
  static const loginLinkClicked = 'loginLinkClicked';
  static const profileSetup = 'profileSetup';

  // Tab View Routes
  static const campaign = 'campaign';
  static const actions = 'actions';
  static const home = 'home';
  static const explore = 'explore';

  static const actionInfo = 'actionInfo';
  // TODO Do we use both cmapaign and campaign info? Remove this probably
  static const campaignInfo = 'campaignInfo';
  static const campaignDetails = 'campaignDetails';

  // Causes
  static const causesEditPage = 'causesEditPage';
  static const causesOnboardingPage = 'causesOnboarding';

  // Other
  static const accountDetails = 'accountDetails';
  static const profile = 'profile';
  static const faq = 'faq';
  static const parteners = 'parteners';
  static const organisationPage = 'organisationPage';
  static const info = 'info';
  static const notification = 'notification';
  static const search = 'search';
}

Function initRoutes = (RouteSettings settings) {
  final args = settings.arguments;

  switch (settings.name) {
    // Into
    case Routes.causesEditPage:
      {
        return customRoute(
          builder: (context) => ChangeSelectCausesView(),
          settings: settings,
        );
      }
    case Routes.causesOnboardingPage:
      {
        return customRoute(
          builder: (context) => OnboardingSelectCausesView(),
          settings: settings,
        );
      }
    case Routes.login:
      {
        return customRoute(
          builder: (context) => LoginView(),
          settings: settings,
        );
      }
    case Routes.emailSent:
    case Routes.loginLinkClicked:
      {
        if (args is EmailSentPageArguments) {
          return customRoute(
            builder: (context) => EmailSentPage(args),
            settings: settings,
          );
        }
        return customRoute(
          builder: (context) => LoginView(),
          settings: settings,
        );
      }
    case Routes.loginCodeInput:
      {
        if (args is String) {
          return customRoute(
            builder: (context) => LoginCodePage(args),
            settings: settings,
          );
        }
        return customRoute(
          builder: (context) => LoginView(),
          settings: settings,
        );
      }
    case Routes.profileSetup:
      {
        return customRoute(
          builder: (context) => ProfileSetupView(),
          settings: settings,
        );
      }

    case Routes.intro:
      {
        return customRoute(
          builder: (context) => IntroView(),
          settings: settings,
        );
      }

    case Routes.faq:
      {
        return customRoute(builder: (context) => FAQView(), settings: settings);
      }
    case Routes.parteners:
      {
        return customRoute(
          builder: (context) => PartnersView(),
          settings: settings,
        );
      }
    case Routes.accountDetails:
      {
        return customRoute(builder: (context) => AccountDetailsPage());
      }

    // Tab page
    case Routes.home:
      {
        return customRoute(
          builder: (context) => TabsView(initialPage: TabPage.Home),
          settings: settings,
        );
      }
    case Routes.explore:
      {
        return customRoute(
          builder: (context) => TabsView(
            initialPage: TabPage.Explore,
            // TODO THis will have broken this but this should be delete dsoon anyway
            explorePageArgs: args is ExplorePageArguments ? args : null,
          ),
          settings: settings,
        );
      }
    case Routes.campaign:
      {
        if (args is ListCampaign) {
          return customRoute(
            builder: (context) => CampaignInfoView(args),
            settings: settings,
          );
        }
        break;
      }
    case Routes.actionInfo:
      {
        if (args is int) {
          return customRoute(
            builder: (context) => ActionInfoView(actionId: args),
            settings: settings,
          );
        }
        break;
      }

    // Other
    case Routes.info:
      {
        if (args is InfoPageArgumnets) {
          return customRoute(
            builder: (context) => InfoPage(args),
            settings: settings,
          );
        }
        return customRoute(
          builder: (context) => TabsView(initialPage: TabPage.Home),
          settings: settings,
        );
      }
    // Other
    case Routes.organisationPage:
      {
        if (args is Organisation) {
          return customRoute(
            builder: (context) => OraganisationInfoPage(args),
            settings: settings,
          );
        }
        return customRoute(
          builder: (context) => PartnersView(),
          settings: settings,
        );
      }

    case Routes.notification:
      {
        if (args is InternalNotification) {
          return customRoute(
            builder: (context) => NotificationPage(args),
            settings: settings,
          );
        }
        break;
      }
    case Routes.search:
      {
        return customRoute(
          builder: (context) => SearchView(),
          settings: settings,
        );
      }

    // TODO add a 404 page
    default:
      {
        return customRoute(
          builder: (context) => TabsView(initialPage: TabPage.Home),
          settings: settings,
        );
      }
  }
};
