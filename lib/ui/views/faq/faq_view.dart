import 'package:flutter/material.dart';

import 'package:nowu/models/FAQ.dart';
import 'package:nowu/assets/components/customScrollableSheet.dart';
import 'package:nowu/assets/components/header.dart';
import 'package:nowu/assets/components/customTile.dart';

import 'package:stacked/stacked.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'faq_viewmodel.dart';

// TODO There is a bug on this page when you tap the last FAQ the answer is not visible without scrolling
// Maybe need something like: https://stackoverflow.com/questions/49153087/flutter-scrolling-to-a-widget-in-listview
class FAQView extends StackedView<FAQViewModel> {
  @override
  FAQViewModel viewModelBuilder(BuildContext context) {
    return FAQViewModel();
  }

  @override
  Widget builder(
    BuildContext context,
    FAQViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: ScrollableSheetPage(
        initialChildSize: 0.85,
        minChildSize: 0.85,
        shadow: const BoxShadow(
          color: Colors.transparent,
        ),
        scaffoldBackgroundColor: const Color.fromRGBO(247, 248, 252, 1),
        sheetBackgroundColor: Colors.white,
        header: Container(
          height: MediaQuery.of(context).size.height * (1 - 0.6),
          child: Stack(
            children: [
              Positioned(
                right: -30,
                bottom: MediaQuery.of(context).size.height * (1 - 0.6) * 0.3,
                child: Image.asset(
                  'assets/imgs/graphics/ilstr_FAQ.png',
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
              ),
              PageHeader(
                backButton: true,
                title: 'FAQs',
              )
            ],
          ),
        ),
        children: [
          !viewModel.dataReady
              // TODO Does this work?
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: viewModel.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FAQTile(viewModel.data!.elementAt(index));
                    },
                  ),
                )
        ],
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              CustomTile(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.faq.question,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      const Icon(
                        FontAwesomeIcons.chevronDown,
                        color: Color.fromRGBO(109, 113, 129, 1),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              selected
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      child: Text(
                        widget.faq.answer,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
