import 'package:flutter/material.dart';

import 'package:app/models/State.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/FAQ.dart';

import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/textButton.dart';
import 'package:app/assets/components/customScrollableSheet.dart';
import 'package:app/assets/components/header.dart';
import 'package:app/assets/components/customTile.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const double CIRCLE_1_RADIUS = 150;
const double CIRCLE_2_RADIUS = 250;

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
              initialChildSize: 0.85,
              minChildSize: 0.85,
              shadow: BoxShadow(
                color: Colors.transparent,
              ),
              scaffoldBackgroundColor: Color.fromRGBO(247,248,252,1),
              sheetBackgroundColor: Colors.white,
              header: 
                Container(
                  height: MediaQuery.of(context).size.height * (1-0.6),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -30,
                        bottom: MediaQuery.of(context).size.height * (1 - 0.6) * 0.3,
                        child: Image.asset(
                          "assets/imgs/graphics/ilstr_FAQ.png",
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                      ),
                      PageHeader(
                        backButton: true,
                        title: "FAQs",
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
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              CustomTile(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.faq.getQuestion(),
                          style: Theme.of(context).primaryTextTheme.headline4,
                        ),
                      ),
                      Icon(
                        FontAwesomeIcons.chevronDown,
                        color: Color.fromRGBO(109,113,129, 1),
                        size: 20,
                      ),
                    ],
                  ),
                )
              ),
              selected 
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    child: Text(
                      widget.faq.getAnswer(),
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    )
                  )
                : Container(),
            ]
          ),
        )
      ),
    );
  }
}
