import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nowu/assets/components/customTile.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/assets/icons/customIcons.dart';
import 'package:nowu/router.dart';
import 'package:nowu/router.gr.dart';
import 'package:nowu/ui/views/authentication/bloc/authentication_bloc.dart';
import 'package:nowu/ui/views/authentication/bloc/authentication_event.dart';
import 'package:nowu/ui/views/authentication/bloc/authentication_state.dart';

sealed class MenuItemData {
  const MenuItemData();
}

sealed class MenuItemAction {
  const MenuItemAction();
}

class RouteMenuItemAction extends MenuItemAction {
  final PageRouteInfo route;
  const RouteMenuItemAction(this.route);
}

class LinkMenuItemAction extends MenuItemAction {
  final Uri link;
  final bool isExternal;
  const LinkMenuItemAction(this.link, {this.isExternal = false});
}

class FunctionMenuItemAction extends MenuItemAction {
  final Future<void> Function() function;
  const FunctionMenuItemAction(this.function);
}

class SectionHeadingMenuItem extends MenuItemData {
  final String title;

  const SectionHeadingMenuItem({
    required this.title,
  });
}

class ActionMenuItem extends MenuItemData {
  final String title;
  final IconData icon;
  final MenuItemAction action;

  const ActionMenuItem({
    required this.title,
    required this.icon,
    required this.action,
  });
}

List<MenuItemData> getMenuItems(AuthenticationBloc authBloc) => [
      const SectionHeadingMenuItem(title: 'The app'),
      ActionMenuItem(
        title: 'About Us',
        icon: FontAwesomeIcons.circleInfo,
        action: LinkMenuItemAction(ABOUT_US_URI),
      ),
      const ActionMenuItem(
        title: 'Collaborations',
        icon: CustomIcons.ic_partners,
        action: RouteMenuItemAction(PartnersRoute()),
      ),
      const ActionMenuItem(
        title: 'FAQ',
        icon: CustomIcons.ic_faq,
        action: RouteMenuItemAction(FaqRoute()),
      ),
      const SectionHeadingMenuItem(title: 'Feedback'),
      ActionMenuItem(
        title: 'Give feedback on the app',
        icon: CustomIcons.ic_feedback,
        action: LinkMenuItemAction(FEEDBACK_FORM_URI),
      ),
      if (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android)
        ActionMenuItem(
          title: 'Rate us on the app store',
          icon: CustomIcons.ic_rateus,
          action: LinkMenuItemAction(
            defaultTargetPlatform == TargetPlatform.iOS
                ? APPLE_APP_STORE_URI
                : GOOGLE_APP_STORE_URI,
            isExternal: true,
          ),
        ),
      ActionMenuItem(
        title: 'Send us a message',
        icon: CustomIcons.ic_social_fb,
        action: LinkMenuItemAction(FACEBOOK_MESSENGER_URI, isExternal: true),
      ),
      ActionMenuItem(
        title: 'Send us an email',
        icon: CustomIcons.ic_email,
        action: LinkMenuItemAction(
          EMAIL_MAILTO_URI,
          isExternal: true,
        ),
      ),
      const SectionHeadingMenuItem(title: 'Legal'),
      ActionMenuItem(
        title: 'Terms & conditions',
        icon: CustomIcons.ic_tc,
        action: LinkMenuItemAction(TERMS_AND_CONDITIONS_URI, isExternal: true),
      ),
      ActionMenuItem(
        title: 'Privacy Notice',
        icon: CustomIcons.ic_privacy,
        action: LinkMenuItemAction(PRIVACY_POLICY_URI, isExternal: true),
      ),
      const SectionHeadingMenuItem(title: 'User'),
      if (authBloc.state is AuthenticationStateAuthenticated)
        const ActionMenuItem(
          title: 'Remove account',
          icon: FontAwesomeIcons.userMinus,
          action: RouteMenuItemAction(DeleteAccountViewRoute()),
        ),
      if (authBloc.state is AuthenticationStateAuthenticated)
        ActionMenuItem(
          title: 'Log out',
          // TODO Get icon
          icon: FontAwesomeIcons.solidUser,
          action: FunctionMenuItemAction(
            () async => authBloc.add(
              const AuthenticationEvent.signOutRequested(),
            ),
          ),
        )
      else
        const ActionMenuItem(
          title: 'Log in',
          // TODO Get icon
          icon: FontAwesomeIcons.solidUser,
          action: RouteMenuItemAction(LoginRoute()),
        ),
    ];

@RoutePage()
class MoreView extends StatelessWidget {
  const MoreView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 45),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                'More',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: getMenuItems(context.read<AuthenticationBloc>())
                  .map((tile) => MenuItem(tile))
                  .toList(),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                SocialButton(
                  icon: FontAwesomeIcons.instagram,
                  link: INSTAGRAM_URI,
                ),
                SocialButton(
                  icon: FontAwesomeIcons.facebookF,
                  link: FACEBOOK_URI,
                ),
                SocialButton(
                  icon: FontAwesomeIcons.twitter,
                  link: TWITTER_URI,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final MenuItemData data;

  const MenuItem(this.data);

  void handleOnTap(BuildContext context, MenuItemAction action) {
    switch (action) {
      case RouteMenuItemAction(:final route):
        context.router.push(route);
      case LinkMenuItemAction(:final link):
        launchLink(link);
        break;
      case FunctionMenuItemAction(:final function):
        function();
        break;
    }
  }

  Widget build(BuildContext context) {
    final data = this.data;
    switch (data) {
      case SectionHeadingMenuItem():
        return Padding(
          padding: const EdgeInsets.only(left: 20, top: 25, bottom: 5),
          child: Text(
            data.title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        );

      case ActionMenuItem():
        {
          return GestureDetector(
            onTap: () => handleOnTap(context, data.action),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              child: CustomTile(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 22, 10, 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 22),
                        child: Icon(
                          data.icon,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        data.title,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    }
  }
}

class SocialButton extends StatelessWidget {
  final double size = 50;
  final IconData icon;
  final Uri link;

  SocialButton({
    required this.icon,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchLinkExternal(context, link),
      child: CustomTile(
        borderRadius: size / 2,
        child: Container(
          height: size,
          width: size,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size / 2),
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
