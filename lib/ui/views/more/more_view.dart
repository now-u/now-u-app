import 'package:flutter/foundation.dart';
import 'package:nowu/app/app.router.dart';
import 'package:nowu/assets/constants.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nowu/assets/icons/customIcons.dart';

import 'package:nowu/assets/components/customTile.dart';

import 'package:nowu/pages/more/ProfileTile.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:stacked/stacked.dart';

import 'more_viewmodel.dart';

sealed class MenuItemData {
  const MenuItemData();
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

final menuItems = <MenuItemData>[
  const SectionHeadingMenuItem(title: 'The app'),
  const ActionMenuItem(
    title: 'About Us',
    icon: FontAwesomeIcons.infoCircle,
    action: LinkMenuItemAction('https://now-u.com/aboutus'),
  ),
  const ActionMenuItem(
    title: 'Our partners',
    icon: CustomIcons.ic_partners,
    action: RouteMenuItemAction(PartnersViewRoute()),
  ),
  const ActionMenuItem(
    title: 'FAQ',
    icon: CustomIcons.ic_faq,
    action: RouteMenuItemAction(FAQViewRoute()),
  ),
  const SectionHeadingMenuItem(title: 'Feedback'),
  const ActionMenuItem(
    title: 'Give feedback on the app',
    icon: CustomIcons.ic_feedback,
    action: LinkMenuItemAction(
      'https://docs.google.com/forms/d/e/1FAIpQLSflMOarmyXRv7DRbDQPWRayCpE5X4d8afOpQ1hjXfdvzbnzQQ/viewform',
    ),
  ),
  if (defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android)
    ActionMenuItem(
      title: 'Rate us on the app store',
      icon: CustomIcons.ic_rateus,
      action: LinkMenuItemAction(
        defaultTargetPlatform == TargetPlatform.iOS
            ? 'https://apps.apple.com/us/app/now-u/id1516126639'
            : 'https://play.google.com/store/apps/details?id=com.nowu.app',
        isExternal: true,
      ),
    ),
  const ActionMenuItem(
    title: 'Send us a message',
    icon: CustomIcons.ic_social_fb,
    action: LinkMenuItemAction('http://m.me/nowufb', isExternal: true),
  ),
  const ActionMenuItem(
    title: 'Send us an email',
    icon: CustomIcons.ic_email,
    action: LinkMenuItemAction('mailto:hello@now-.com?subject=Hi',
        isExternal: true),
  ),
  const SectionHeadingMenuItem(title: 'Legal'),
  const ActionMenuItem(
    title: 'Terms & conditions',
    icon: CustomIcons.ic_tc,
    action: LinkMenuItemAction(TERMS_AND_CONDITIONS_URL, isExternal: true),
  ),
  const ActionMenuItem(
    title: 'Privacy Notice',
    icon: CustomIcons.ic_privacy,
    action: LinkMenuItemAction(PRIVACY_POLICY_URL, isExternal: true),
  ),
  const SectionHeadingMenuItem(title: 'User'),
  ActionMenuItem(
    title: 'Log out',
    // TODO Get icon
    icon: FontAwesomeIcons.solidUser,
    action: FunctionMenuItemAction((model) => model.logout()),
  ),
];

///The More page ![More Page](https://i.ibb.co/xDHyMPj/slack.png)
///
/// This Widget takes in the [menuItems] and goes over it
/// checking if the elements inside it is either sectionHeading
/// or [ProfileTile]
class MoreView extends StackedView<MoreViewModel> {
  @override
  MoreViewModel viewModelBuilder(BuildContext context) => MoreViewModel();

  @override
  Widget builder(
    BuildContext context,
    MoreViewModel viewModel,
    Widget? child,
  ) {
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
              children: menuItems
                  .map((tile) => MenuItem(tile, viewModel: viewModel, index: 2))
                  .toList(),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                SocialButton(
                  icon: FontAwesomeIcons.instagram,
                  link: 'https://www.instagram.com/now_u_app/',
                ),
                SocialButton(
                  icon: FontAwesomeIcons.facebookF,
                  link: 'https://www.facebook.com/nowufb',
                ),
                SocialButton(
                  icon: FontAwesomeIcons.twitter,
                  link: 'https://twitter.com/now_u_app',
                )
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
  final int index;
  final MoreViewModel viewModel;

  const MenuItem(this.data, {required this.index, required this.viewModel});

  Widget build(BuildContext context) {
    final data = this.data;
    switch (data) {
      case SectionHeadingMenuItem():
        return Padding(
          padding:
              EdgeInsets.only(left: 20, top: index == 0 ? 0 : 25, bottom: 5),
          child: Text(
            data.title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        );

      case ActionMenuItem():
        {
          return GestureDetector(
            onTap: () => viewModel.performMenuItemAction(data.action),
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
                        padding: const EdgeInsets.only(right: ICON_PADDING),
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
  final IconData? icon;
  final String? link;

  SocialButton({
    this.icon,
    this.link,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launch(link!);
      },
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
