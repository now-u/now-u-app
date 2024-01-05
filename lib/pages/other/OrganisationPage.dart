import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/assets/components/customTile.dart';
import 'package:nowu/assets/components/custom_network_image.dart';
import 'package:nowu/assets/components/header.dart';
import 'package:nowu/assets/components/sectionTitle.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/models/Organisation.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:url_launcher/url_launcher.dart';

final double SECTION_TITLE_BOTTOM_PADDING = 8;
final double BETWEEN_SECTION_PADDING = 12;

final NavigationService? _navigationService = locator<NavigationService>();

class OraganisationInfoPage extends StatelessWidget {
  final Organisation organisation;
  OraganisationInfoPage(
    this.organisation,
  );

  @override
  Widget build(BuildContext context) {
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
                // organisation.getCampaigns()!.length > 0
                //     ? Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //             SizedBox(height: BETWEEN_SECTION_PADDING),
                //             SectionTitle(
                //               "Associated campaigns",
                //               vpadding: SECTION_TITLE_BOTTOM_PADDING,
                //             ),
                //             Container(
                //               height: 120,
                //               child: PageView.builder(
                //                 itemCount: organisation.getCampaigns()!.length,
                //                 itemBuilder: (BuildContext context, int index) {
                //                   return CampaignSelectionTile(
                //                     organisation.getCampaigns()![index],
                //                     height: 120,
                //                   );
                //                 },
                //               ),
                //             ),
                //           ])
                //     : Container(),
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
                getSocialMediaChildren(organisation).length == 0
                    ? Container()
                    : SectionTitle(
                        'Follow this partner on social media',
                        vpadding: SECTION_TITLE_BOTTOM_PADDING,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: getSocialMediaChildren(organisation),
                ),
                getSocialMediaChildren(organisation).length == 0
                    ? Container()
                    : SizedBox(height: BETWEEN_SECTION_PADDING),
                getExtraLinks(organisation).length == 0
                    ? Container()
                    : SectionTitle(
                        'Find out more',
                      ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: getExtraLinks(organisation),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> getSocialMediaChildren(Organisation org) {
  List<Widget> socialButtons = [];
  if (org.instagramLink case var instagramLink?) {
    socialButtons
        .add(SocialMediaButton(instagramLink, FontAwesomeIcons.instagram));
  }
  if (org.facebookLink case var facebookLink?) {
    socialButtons
        .add(SocialMediaButton(facebookLink, FontAwesomeIcons.facebookF));
  }
  if (org.twitterLink case var twitterLink?) {
    socialButtons.add(SocialMediaButton(twitterLink, FontAwesomeIcons.twitter));
  }
  if (org.emailAddress case var emailAddress?) {
    socialButtons
        .add(SocialMediaButton(emailAddress, FontAwesomeIcons.envelope));
  }
  if (org.websiteLink case var websiteLink?) {
    socialButtons.add(SocialMediaButton(websiteLink, Icons.language));
  }
  return socialButtons;
}

class SocialMediaButton extends StatelessWidget {
  final String link;
  final IconData icon;

  SocialMediaButton(this.link, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(
          icon,
          color: const Color.fromRGBO(155, 159, 177, 1),
          size: 35,
        ),
        onPressed: () {
          launchUrl(Uri.parse(link));
        },
      ),
    );
  }
}

List<Widget> getExtraLinks(Organisation org) {
  return org.extraLinks
      .map((link) => ExtraLinkButton(link.title, link.link))
      .toList();
}

class ExtraLinkButton extends StatelessWidget {
  final String? text;
  final String? link;
  ExtraLinkButton(this.text, this.link);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: CustomTile(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            text!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: CustomColors.brandColor,
                  fontWeight: FontWeight.w800,
                ),
            textAlign: TextAlign.center,
          ),
        ),
        onClick: () {
          _navigationService!.launchLink(link!);
        },
      ),
    );
  }
}
