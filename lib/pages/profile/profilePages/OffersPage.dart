import 'package:flutter/material.dart';
import 'package:app/assets/components/pageTitle.dart';
import 'package:app/models/Offer.dart';

var _offers = <Offer>[ 
  Offer(id: 1, title: "20% of VegWare", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", link: "https://www.vegware.com/uk/" ),
  Offer(id: 1, title: "20% of VegWare", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", link: "https://www.vegware.com/uk/" ),
  Offer(id: 1, title: "20% of VegWare", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", link: "https://www.vegware.com/uk/" ),
  Offer(id: 1, title: "20% of VegWare", description: "Vegi Cup is a company that make compsotable single use cutlery etc.", link: "https://www.vegware.com/uk/" ),
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
              PageTitle("My Details", hasBackButton: true, onClickBackButton: _goBack,),
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
    return Container(
      child: Text("${_offer.getTitle()}"),
    );
  }
}
