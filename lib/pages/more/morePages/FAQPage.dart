import 'package:flutter/material.dart';

import 'package:app/models/FAQ.dart';

import 'package:app/assets/components/customScrollableSheet.dart';
import 'package:app/assets/components/header.dart';
import 'package:app/assets/components/customTile.dart';

import 'package:stacked/stacked.dart';
import 'package:app/viewmodels/faq_model.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const double CIRCLE_1_RADIUS = 150;
const double CIRCLE_2_RADIUS = 250;

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<FAQViewModel>.reactive(
        viewModelBuilder: () => FAQViewModel(),
        onModelReady: (model) => model.fetchFAQs(),
        builder: (context, model, child) {
          return ScrollableSheetPage(
              initialChildSize: 0.85,
              minChildSize: 0.85,
              shadow: BoxShadow(
                color: Colors.transparent,
              ),
              scaffoldBackgroundColor: Color.fromRGBO(247, 248, 252, 1),
              sheetBackgroundColor: Colors.white,
              header: Container(
                height: MediaQuery.of(context).size.height * (1 - 0.6),
                child: Stack(
                  children: [
                    Positioned(
                      right: -30,
                      bottom:
                          MediaQuery.of(context).size.height * (1 - 0.6) * 0.3,
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
                    itemCount: model.faqs!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FAQTile(model.faqs![index]);
                    },
                  ),
                )
              ]);
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
  late bool selected;
  @override
  void initState() {
    selected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            child: Column(children: [
              CustomTile(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.faq.question,
                        style: Theme.of(context).primaryTextTheme.headline4,
                      ),
                    ),
                    Icon(
                      FontAwesomeIcons.chevronDown,
                      color: Color.fromRGBO(109, 113, 129, 1),
                      size: 20,
                    ),
                  ],
                ),
              )),
              selected
                  ? Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      child: Text(
                        widget.faq.answer,
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                      ))
                  : Container(),
            ]),
          )),
    );
  }
}
