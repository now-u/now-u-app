import 'package:flutter/material.dart';

import 'package:app/models/State.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/FAQ.dart';

import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/textButton.dart';
import 'package:app/assets/components/customScrollableSheet.dart';
import 'package:app/assets/components/header.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

const double CIRCLE_1_RADIUS = 150;
const double CIRCLE_2_RADIUS = 250;
const double HEADING_HEIGHT = 250;

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {
        return FutureBuilder(
          future: viewModel.api.getFAQs(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ScrollableSheetPage(
              header: 
                Container(
                  color: Color.fromRGBO(247,248,252,1),
                  height: MediaQuery.of(context).size.height * (1-0.6),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -30,
                        bottom: -10,
                        child: Image.asset(
                          "assets/imgs/graphics/ilstr_learning@3x.png",
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                      ),
                      PageHeader(
                        title: "Learning Hub",
                      )
                    ],
                  ),
                ),
              children: [
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FAQTile(snapshot.data[index]);
                    },
                  ),
                )
              ]
            );
          },
        );
      },
      ),
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
