import 'package:flutter/material.dart';

import 'package:app/models/State.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/FAQ.dart';

import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/textButton.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

const double CIRCLE_1_RADIUS = 150;
const double CIRCLE_2_RADIUS = 250;
const double HEADING_HEIGHT = 250;

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        StoreConnector<AppState, ViewModel>(
          converter: (Store<AppState> store) => ViewModel.create(store),
          builder: (BuildContext context, ViewModel viewModel) {
            return FutureBuilder(
              future: viewModel.api.getFAQs(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                      child: ListView(
                    children: [
                      Container(
                        color: Colors.white,
                        height: HEADING_HEIGHT,
                        child: Stack(
                          children: [
                            Positioned(
                                top: -40,
                                left: MediaQuery.of(context).size.width * 0.5 -
                                    40,
                                child: Container(
                                  height: CIRCLE_1_RADIUS,
                                  width: CIRCLE_1_RADIUS,
                                  decoration: BoxDecoration(
                                    color: colorFrom(
                                      Theme.of(context).primaryColor,
                                      opacity: 0.2,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        CIRCLE_1_RADIUS / 2),
                                  ),
                                )),
                            Positioned(
                                top: 120,
                                left: -80,
                                child: Container(
                                  height: CIRCLE_2_RADIUS,
                                  width: CIRCLE_2_RADIUS,
                                  decoration: BoxDecoration(
                                    color: colorFrom(
                                      Theme.of(context).primaryColor,
                                      opacity: 0.2,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        CIRCLE_2_RADIUS / 2),
                                  ),
                                )),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                "assets/imgs/learning.png",
                                height: 180,
                              ),
                            ),
                            SafeArea(
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextButton(
                                            "Menu",
                                            onClick: () {
                                              Navigator.of(context).pop();
                                            },
                                            iconLeft: true,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "FAQs",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .headline2,
                                          )
                                        ],
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return FAQTile(snapshot.data[index]);
                        },
                      ),
                    ],
                  ));
                  //return ListView.builder(
                  //  shrinkWrap: true,
                  //  itemBuilder: (BuildContext context, int index) {
                  //    //return Text(snapshot.data[index].getQuestion());
                  //    return Text(index.toString());
                  //  },
                  //);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        )
      ]),
    );
  }
}

class FAQTile extends StatefulWidget {
  final FAQ faq;
  FAQTile(this.faq);
  @override
  _FAQTileState createState() => _FAQTileState();
}

class _FAQTileState extends State<FAQTile> {
  bool selected;
  @override
  void initState() {
    selected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("FAQ question is ${widget.faq.getQuestion()}");
    print("FAQ answer is ${widget.faq.getAnswer()}");
    return Container(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ExpansionTile(
            title: Text(widget.faq.getQuestion()),
            trailing: SizedBox(),
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(widget.faq.getAnswer()),
              )
            ],
          )
        ),
      )
    );
  }
}
