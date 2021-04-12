import 'package:app/assets/components/textButton.dart';
import 'package:app/services/navigation_service.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:app/assets/components/customAppBar.dart';

import 'package:stacked/stacked.dart';
import 'package:app/viewmodels/web_view_model.dart';

class WebViewArguments {
  final String initialUrl;

  WebViewArguments(this.initialUrl);
}

class WebViewPage extends StatefulWidget {
  final WebViewArguments args;
  WebViewPage(this.args);
  

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        backButtonText: "Back",
        context: context,
        actions: [
         Padding(
           padding: const EdgeInsets.all(12.0),
           child: DropdownButton<String>(
             iconEnabledColor: Theme.of(context).primaryColor,
             isDense: true,
             items: <String>['Open'].map((String stringValue) {
                 return DropdownMenuItem<String>(
                   value: stringValue,
                   child: CustomTextButton(
              stringValue,
              onClick: (){
                NavigationService()
                .launchLink(
                  widget.args.initialUrl,
                  isExternal: true,
                  title: 'Open with an External Browser?',
                  description: 'You are about to open this link with an external browser..',
                  buttonText: 'Yes, Go Ahead',
                  closeButtonText: 'Stay Here'
                  );
              }),
              );
             }).toList(),
             onChanged: (_){},
         ))
        ]
      ),
      body: SafeArea(
          child: ViewModelBuilder<WebViewViewModel>.reactive(
              viewModelBuilder: () => WebViewViewModel(),
              builder: (context, model, child) {
                return WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: widget.args.initialUrl,
                  onWebResourceError: (error) {
                    model.onWebError(widget.args.initialUrl);
                  },
                );
              })),
    );
  }
}
