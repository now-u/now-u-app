import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:nowu/ui/dialogs/basic/basic_dialog.dart';
import 'package:nowu/ui/views/home/home_view.dart';
import 'package:url_launcher/url_launcher.dart';

import 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: StartupRoute.page, initial: true),
        AutoRoute(path: '/intro', page: IntroRoute.page),
        AutoRoute(path: '/login', page: LoginRoute.page),
        AutoRoute(path: '/login/email_sent', page: LoginEmailSentRoute.page),
        AutoRoute(path: '/login/email_code', page: LoginCodeRoute.page),
        AutoRoute(path: '/login/email_code', page: LoginCodeRoute.page),
        AutoRoute(path: '/onboarding/profile', page: ProfileSetupRoute.page),
        AutoRoute(
            path: '/onboarding/causes', page: OnboardingSelectCausesRoute.page),
        AutoRoute(
          path: '/',
          page: TabsRoute.page,
          children: [
            AutoRoute(path: 'home', page: HomeRoute.page, initial: true),
            AutoRoute(
              path: 'explore',
              page: ExploreRoute.page,
              children: [],
            ),
            AutoRoute(path: 'more', page: MoreRoute.page),
          ],
        ),
        AutoRoute(path: '/actions/:actionId', page: ActionInfoRoute.page),
        AutoRoute(path: '/campaigns/:campaignId', page: CampaignInfoRoute.page),
        AutoRoute(path: '/collaborations', page: PartnersRoute.page),
        AutoRoute(
            path: '/collaborations/:partnerId', page: PartnerInfoRoute.page),
        AutoRoute(path: '/faqs', page: FaqRoute.page),
      ];

  Future<void> launchLink(Uri url, { bool isExternal = false }) async {
    await launchUrl(url, mode: LaunchMode.externalApplication);
	launchLinkExternal(this.navigatorKey.currentContext!, url);
  }
}

void launchLink(Uri url) {
  final browser = locator<CustomChromeSafariBrowser>();
  browser.open(url: url);
}

// TODO Move somewhere
void launchLinkExternal(BuildContext context, Uri url) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BasicDialog(
        BasicDialogArgs(
          title: "You're about to leave",
          description:
              'This link will take you out of the app. Are you sure you want to go?',
          mainButtonArgs: BasicDialogButtonArgs(
            text: "Let's go",
            onClick: () async {
              context.router.maybePop();
              await launchUrl(url, mode: LaunchMode.externalApplication);
            },
          ),
          secondaryButtonArgs: BasicDialogButtonArgs(
            text: 'Close',
            onClick: () {
              context.router.maybePop();
            },
          ),
        ),
      );
    },
  );
}

// import 'package:go_router/go_router.dart';
// import 'package:nowu/ui/views/action_info/action_info_view.dart';
// import 'package:nowu/ui/views/explore/explore_page_view.dart';
// import 'package:nowu/ui/views/home/home_view.dart';
// import 'package:nowu/ui/views/more/more_view.dart';
// import 'package:nowu/ui/views/startup/startup_view.dart';
// import 'package:nowu/ui/views/tabs/tabs_view.dart';
// part 'router.g.dart';

// @TypedGoRoute<HomeRoute>(
// 	path: '/',
// 	routes: [
// 		TypedGoRoute<ExploreRoute>(
// 			path: '/explore',
// 		),
// 	],
// )
// class HomeRoute extends GoRouteData {
// 	const HomeRoute();
//
// 	@override
// 	Widget build(BuildContext context, GoRouterState state) => const HomeView();
// }
//
// class ActionInfoRoute extends GoRouteData {
// 	const ActionInfoRoute(this.actionId);
//
// 	final int actionId;
//
// 	@override
// 	Widget build(BuildContext context, GoRouterState state) => ActionInfoView(actionId: actionId);
// }
//
// // TODO
// class ExploreRoute extends GoRouteData {
// }
//
// final _router = GoRouter(
// 	routes: $appRoutes,
// );
//
// GoRouter configuration
// final _router = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) => const StartupView(),
//     ),
//     StatefulShellRoute.indexedStack(
//         builder: (context, state, navigationShell) {
// 			return TabsView();
// 		},
//         branches: [
// 			StatefulShellBranch(
// 				routes: <RouteBase>[
// 					GoRoute(
// 						path: 'home',
// 						builder: (context, state) => const HomeView(),
// 					),
// 					// TODO Add nested tabs https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart#L66
// 					GoRoute(
// 						path: 'explore',
// 						builder: (context, state) => ExplorePage(
// 							// TODO Store the fitler params in the URL params. Use existing class to parse and write
// 							filterData: null,
// 						),
// 					),
// 					GoRoute(
// 						path: 'more',
// 						builder: (context, state) => const MoreView(),
// 					),
// 				],
// 			),
// 		],
// 	),
//     GoRoute(
//       path: 'action/:actionId',
//       builder: (context, state) => ActionInfoView(
// 		actionId: int.parse(state.pathParameters['authorId']!),
// 	  ),
//     ),
//   ],
// );
