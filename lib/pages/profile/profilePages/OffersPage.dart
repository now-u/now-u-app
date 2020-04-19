import 'package:flutter/material.dart';
import 'package:app/assets/components/pageTitle.dart';
import 'package:app/models/Offer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const double ICON_PADDING = 40;
const double ITEM_HORIZONTAL = 30;
const double ITEM_VERTICAL = 30;

var _offers = <Offer>[ 
  Offer(id: 1, title: "20% of VegWare", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", link: "https://www.vegware.com/uk/" ),
  Offer(id: 1, title: "20% of VegWare", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", link: "https://www.vegware.com/uk/" ),
  Offer(id: 1, title: "20% of VegWare", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", link: "https://www.vegware.com/uk/" ),
  Offer(id: 1, title: "22% of VegWare", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", link: "https://www.vegware.com/uk/" ),
  Offer(id: 1, title: "22% of VegWare", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", link: "https://www.vegware.com/uk/" ),
  Offer(id: 1, title: "22% of VegWare", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", link: "https://www.vegware.com/uk/" ),
  Offer(id: 1, title: "24% of VegWare", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", link: "https://www.vegware.com/uk/" ),
];

class OffersPage extends StatelessWidget {
  GestureTapCallback _goBack;
  
  OffersPage(goBack) {
    _goBack = goBack;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
            children: <Widget>[
              PageTitle("Offers", hasBackButton: true, onClickBackButton: _goBack,),
              Expanded(
                child:
                  ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: _offers.length,
                    itemBuilder: (context, index) => 
                      GestureDetector(
                        // TODO Offer more info page
                        onTap: () {},
                        child: OfferTile(_offers[index]),
                      ),
                  ),
              ),
            ]
          );
  }
}

class OfferTile extends StatelessWidget {
  Offer _offer;
  OfferTile(offer) {
    _offer = offer; 
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.fromLTRB(ITEM_HORIZONTAL, ITEM_VERTICAL, ITEM_HORIZONTAL, ITEM_VERTICAL),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding( 
                padding: EdgeInsets.only(right: ICON_PADDING),
                child: Icon(FontAwesomeIcons.percent, size: 50,)
            ),
            Text(_offer.getTitle(), style: Theme.of(context).primaryTextTheme.body1),
          ],
        ),
      )
    );
  }
}
