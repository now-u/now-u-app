import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nowu/assets/StyleFrom.dart';
import 'package:nowu/assets/components/customTile.dart';
import 'package:nowu/assets/components/custom_network_image.dart';
import 'package:nowu/assets/components/header.dart';
import 'package:nowu/assets/components/sectionTitle.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/models/Organisation.dart';
import 'package:stacked/stacked.dart';

import 'partner_info_viewmodel.dart';

final double SECTION_TITLE_BOTTOM_PADDING = 8;
final double BETWEEN_SECTION_PADDING = 12;

class PartnerInfoView extends StackedView<PartnerInfoViewModel> {
  final Organisation organisation;
  const PartnerInfoView({Key? key, required this.organisation})
      : super(key: key);

  Iterable<Widget> getSocialMediaChildren(
      Organisation org, PartnerInfoViewModel viewModel,) {
    final List<({String? link, IconData icon})> socialButtons = [
      (link: org.instagramLink, icon: FontAwesomeIcons.instagram),
      (link: org.facebookLink, icon: FontAwesomeIcons.facebookF),
      (link: org.twitterLink, icon: FontAwesomeIcons.twitter),
      (link: org.emailAddress, icon: FontAwesomeIcons.envelope),
      (link: org.websiteLink, icon: Icons.language),
    ];
    return socialButtons
        .where((button) => button.link != null)
        .map(
          (button) => SocialMediaButton(
              icon: button.icon,
              onPressed: () => viewModel.launchLink(button.link!),),
        )
        .toList();
  }

  Iterable<Widget> getExtraLinks(
      Organisation org, PartnerInfoViewModel viewModel,) {
    return org.extraLinks.map((link) => ExtraLinkButton(
        title: link.title, onClick: () => viewModel.launchLink(link.link),),);
  }

  @override
  Widget builder(
    BuildContext context,
    PartnerInfoViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Body
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: <Widget>[
                PageHeader(
                  title: organisation.name,
                  backButton: true,
                  padding: 0,
                ),
                const SizedBox(height: 10),
                Container(
                  height: 120,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: CustomNetworkImage(organisation.logo.url),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SectionTitle(
                  'About',
                  vpadding: SECTION_TITLE_BOTTOM_PADDING,
                ),
                Text(
                  organisation.descriptionClean,
                ),
                SizedBox(height: BETWEEN_SECTION_PADDING),
                organisation.geographicReach == null
                    ? Container()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionTitle(
                            'Geographic reach',
                            vpadding: SECTION_TITLE_BOTTOM_PADDING,
                          ),
                          Text(
                            organisation.geographicReach!,
                          ),
                        ],
                      ),
                SizedBox(height: BETWEEN_SECTION_PADDING),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(
                      'Organisation type',
                      vpadding: SECTION_TITLE_BOTTOM_PADDING,
                    ),
                    Text(
                      organisation.organisationTypeMeta.name,
                    ),
                  ],
                ),
                SizedBox(height: BETWEEN_SECTION_PADDING),
                getSocialMediaChildren(organisation, viewModel).length == 0
                    ? Container()
                    : SectionTitle(
                        'Follow this partner on social media',
                        vpadding: SECTION_TITLE_BOTTOM_PADDING,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children:
                      getSocialMediaChildren(organisation, viewModel).toList(),
                ),
                getSocialMediaChildren(organisation, viewModel).length == 0
                    ? Container()
                    : SizedBox(height: BETWEEN_SECTION_PADDING),
                getExtraLinks(organisation, viewModel).length == 0
                    ? Container()
                    : SectionTitle(
                        'Find out more',
                      ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: getExtraLinks(organisation, viewModel).toList(),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  PartnerInfoViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PartnerInfoViewModel();
}

class SocialMediaButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const SocialMediaButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(
          icon,
          color: const Color.fromRGBO(155, 159, 177, 1),
          size: 35,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class ExtraLinkButton extends StatelessWidget {
  final String title;
  final VoidCallback onClick;

  const ExtraLinkButton({
    required this.title,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: CustomTile(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title,
            style: textStyleFrom(
              Theme.of(context).textTheme.bodyLarge,
              color: CustomColors.brandColor,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        onClick: onClick,
      ),
    );
  }
}
