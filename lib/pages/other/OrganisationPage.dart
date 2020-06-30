import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/header.dart';
import 'package:app/assets/components/sectionTitle.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/models/Organisation.dart';

final double SECTION_TITLE_BOTTOM_PADDING = 8;
final double BETWEEN_SECTION_PADDING = 12;

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
              child: Center(
                child: Image.network(organisation.getLogoLink())
              ),
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
                
                SizedBox(height: BETWEEN_SECTION_PADDING),
               
                organisation.getGeographicReach() == null ? Container() :
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(
                      "Geographic reach",
                      vpadding: SECTION_TITLE_BOTTOM_PADDING,
                    ),
                    Text(
                      organisation.getGeographicReach(),
                    ),
                  ]
                ),

                SizedBox(height: BETWEEN_SECTION_PADDING),

                organisation.getOrganistaionType() == null ? Container() :
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(
                      "Organisation type",
                      vpadding: SECTION_TITLE_BOTTOM_PADDING,
                    ),
                    Text(
                      organisation.getOrganistaionType(),
                    ),
                  ]
                ),

                SizedBox(height: BETWEEN_SECTION_PADDING),

                getSocialMediaChildren(organisation).length == 0 ? Container() :
                SectionTitle(
                  "Follow this partner on social media",
                  vpadding: SECTION_TITLE_BOTTOM_PADDING
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: getSocialMediaChildren(organisation),
                ),
                getSocialMediaChildren(organisation).length == 0 ? Container() :

                SizedBox(height: BETWEEN_SECTION_PADDING),

                getExtraLinks(organisation).length == 0 ? Container() :
                SectionTitle(
                  "Find out more",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: getExtraLinks(organisation),
                ),

                SizedBox(height: 20),

              ],
            )
          )
        ],
      ),
    );
  }
}

List<Widget> getSocialMediaChildren(Organisation org) {
  List<Widget> socialButtons = [];
  if (org.getInstagram() != null) {
    socialButtons.add(SocialMediaButton(org.getInstagram(), FontAwesomeIcons.instagram));
  }
  if (org.getFacebook() != null) {
    socialButtons.add(SocialMediaButton(org.getFacebook(), FontAwesomeIcons.facebookF));
  }
  if (org.getTwitter() != null) {
    socialButtons.add(SocialMediaButton(org.getTwitter(), FontAwesomeIcons.twitter));
  }
  if (org.getEmail() != null) {
    socialButtons.add(SocialMediaButton(org.getEmail(), FontAwesomeIcons.envelope));
  }
  if (org.getWebsite() != null) {
    socialButtons.add(SocialMediaButton(org.getWebsite(), Icons.web));
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
          color: Color.fromRGBO(155,159,177,1),
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
    extraLinks.add(ExtraLinkButton(org.getExtraText1(), org.getExtraLink1(), FontAwesomeIcons.externalLinkAlt));
  }
  if (org.getExtraText2() != null) {
    extraLinks.add(ExtraLinkButton(org.getExtraText2(), org.getExtraLink2(), FontAwesomeIcons.externalLinkAlt));
  }
  if (org.getExtraText3() != null) {
    extraLinks.add(ExtraLinkButton(org.getExtraText3(), org.getExtraLink3(), FontAwesomeIcons.externalLinkAlt));
  }
  return extraLinks;
}

class ExtraLinkButton extends StatelessWidget {
  final String text;
  final String link;
  final IconData icon;
  ExtraLinkButton(this.text, this.link, this.icon);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launch(link);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 45, 96, 0.08),
              offset: Offset(0, 3),
              blurRadius: 20,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Icon(
                icon,
                color: Color.fromRGBO(155,159,177,1),
                size: 25,
              ),
              SizedBox(height: 10),
              Text(
                text,
                style: textStyleFrom(
                  Theme.of(context).primaryTextTheme.bodyText1,
                  color: Color.fromRGBO(155,159,177,1),
                ),
              )
            ],
          ),
        )
    )
  );
  }
}
