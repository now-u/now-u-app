import 'package:flutter/material.dart';
import 'package:app/assets/components/pageTitle.dart';
import 'package:app/models/FAQ.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

const double ICON_SIZE = 50;
const double ICON_TPADDING = 0;
const double ICON_BPADDING = 20;
const double ICON_HPADDING = 30;

var _faqs = <FAQ> [
  FAQ(id: 0, question: "What is your favorite colour", answer: "My favorite colour is the best coloour ever its the color that looks like the color blue but is actually the color red"),
];

class SupportPage extends StatelessWidget {
  GestureTapCallback _goBack;
  
  SupportPage(goBack) {
    _goBack = goBack;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
            children: <Widget>[
              PageTitle("Support", hasBackButton: true, onClickBackButton: _goBack,),
              Expanded(
                child:
                  ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: _faqs.length,
                    itemBuilder: (context, index) => 
                      GestureDetector(
                        // TODO Offer more info page
                        onTap: () {},
                        child: FAQTile(_faqs[index]),
                      ),
                  ),
              ),
              Text("Contact Us", style: Theme.of(context).primaryTextTheme.headline,),
              Padding(
                padding: EdgeInsets.all(15),
                child:
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                      Padding( 
                        padding: EdgeInsets.fromLTRB(ICON_HPADDING, ICON_TPADDING, ICON_HPADDING, ICON_BPADDING),
                        child: IconButton(icon: Icon(FontAwesomeIcons.facebookMessenger, size: ICON_SIZE,), onPressed: () {launch("http://m.me/nowufb");})
                      ),
                      Padding( 
                        padding: EdgeInsets.fromLTRB(ICON_HPADDING, ICON_TPADDING, ICON_HPADDING, ICON_BPADDING),
                        child: IconButton(icon: Icon(FontAwesomeIcons.envelopeOpen, size: ICON_SIZE,), onPressed: () {launch("http://m.me/nowufb");})
                      ),
                      Padding( 
                        padding: EdgeInsets.fromLTRB(ICON_HPADDING, ICON_TPADDING, ICON_HPADDING, ICON_BPADDING),
                        child: IconButton(icon: Icon(FontAwesomeIcons.pollH, size: ICON_SIZE,), onPressed: () {launch("http://m.me/nowufb");})
                      ),
                     ], 
                  ),
                )
            ]
          );
  }
}

class FAQTile extends StatelessWidget {
  FAQ _faq;
  FAQTile(faq) {
    _faq = faq; 
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(_faq.getQuestion()),
      )
    );
  }
}
