import 'package:app/assets/components/header.dart';
import 'package:app/assets/components/sectionTitle.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/assets/components/customTile.dart';
import 'package:app/assets/components/campaignTile.dart';
import 'package:app/assets/StyleFrom.dart';

import 'package:app/models/Organisation.dart';

import 'package:app/locator.dart';
import 'package:app/services/navigation.dart';

final double SECTION_TITLE_BOTTOM_PADDING = 8;
final double BETWEEN_SECTION_PADDING = 12;
  
final NavigationService _navigationService = locator<NavigationService>();

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
            padding: EdgeInsets.symmetric(horizontal: 15),
            children: <Widget>[
              PageHeader(
                title: organisation.getName(),
                backButton: true,
                padding: 0,
              ),
              SizedBox(height: 10),
              Container(
                height: 120,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child:
                      Center(child: Image.network(organisation.getLogoLink())),
                ),
              ),
              SizedBox(height: 10),
              SectionTitle(
                "About",
                vpadding: SECTION_TITLE_BOTTOM_PADDING,
              ),
              Text(
                organisation.getDescription(),
              ),
              organisation.getCampaigns().length > 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          SizedBox(height: BETWEEN_SECTION_PADDING),
                          SectionTitle(
                            "Associated campaigns",
                            vpadding: SECTION_TITLE_BOTTOM_PADDING,
                          ),
                          Container(
                            height: 120,
                            child: PageView.builder(
                              itemCount: organisation.getCampaigns().length,
                              itemBuilder: (BuildContext context, int index) {
                                return CampaignSelectionTile(
                                  organisation.getCampaigns()[index],
                                  height: 120,
                                );
                              },
                            ),
                          ),
                        ])
                  : Container(),
              SizedBox(height: BETWEEN_SECTION_PADDING),
              organisation.getGeographicReach() == null
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          SectionTitle(
                            "Geographic reach",
                            vpadding: SECTION_TITLE_BOTTOM_PADDING,
                          ),
                          Text(
                            organisation.getGeographicReach(),
                          ),
                        ]),
              SizedBox(height: BETWEEN_SECTION_PADDING),
              organisation.getOrganistaionType() == null
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          SectionTitle(
                            "Organisation type",
                            vpadding: SECTION_TITLE_BOTTOM_PADDING,
                          ),
                          Text(
                            organisation.getOrganistaionType(),
                          ),
                        ]),
              SizedBox(height: BETWEEN_SECTION_PADDING),
              getSocialMediaChildren(organisation).length == 0
                  ? Container()
                  : SectionTitle("Follow this partner on social media",
                      vpadding: SECTION_TITLE_BOTTOM_PADDING),
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
                      "Find out more",
                    ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: getExtraLinks(organisation),
              ),
              SizedBox(height: 20),
            ],
          ))
        ],
      ),
    );
  }
}

List<Widget> getSocialMediaChildren(Organisation org) {
  List<Widget> socialButtons = [];
  if (org.getInstagram() != null) {
    socialButtons
        .add(SocialMediaButton(org.getInstagram(), FontAwesomeIcons.instagram));
  }
  if (org.getFacebook() != null) {
    socialButtons
        .add(SocialMediaButton(org.getFacebook(), FontAwesomeIcons.facebookF));
  }
  if (org.getTwitter() != null) {
    socialButtons
        .add(SocialMediaButton(org.getTwitter(), FontAwesomeIcons.twitter));
  }
  if (org.getEmail() != null) {
    socialButtons
        .add(SocialMediaButton(org.getEmail(), FontAwesomeIcons.envelope));
  }
  if (org.getWebsite() != null) {
    socialButtons.add(SocialMediaButton(org.getWebsite(), Icons.language));
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
          color: Color.fromRGBO(155, 159, 177, 1),
          size: 35,
        ),
        onPressed: () {
          launch(link);
        },
      ),
    );
  }
}

List<Widget> getExtraLinks(Organisation org) {
  List<Widget> extraLinks = [];
  if (org.getExtraText1() != null) {
    extraLinks.add(ExtraLinkButton(org.getExtraText1(), org.getExtraLink1()));
  }
  if (org.getExtraText2() != null) {
    extraLinks.add(ExtraLinkButton(org.getExtraText2(), org.getExtraLink2()));
  }
  if (org.getExtraText3() != null) {
    extraLinks.add(ExtraLinkButton(org.getExtraText3(), org.getExtraLink3()));
  }
  return extraLinks;
}

class ExtraLinkButton extends StatelessWidget {
  final String text;
  final String link;
  ExtraLinkButton(this.text, this.link);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8),
        child: CustomTile(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              text,
              style: textStyleFrom(
                Theme.of(context).primaryTextTheme.headline5,
                color: Theme.of(context).buttonColor,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          onClick: () {
            _navigationService.launchLink(link);
          },
        ));
  }
}
