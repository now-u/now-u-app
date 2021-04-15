import 'package:app/assets/components/textButton.dart';
import 'package:app/services/navigation_service.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:app/assets/components/customAppBar.dart';

import 'package:stacked/stacked.dart';
import 'package:app/viewmodels/web_view_model.dart';

import '../../locator.dart';

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

 final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        backButtonText: "Back",
        context: context,
<<<<<<< HEAD
        actions: <Widget>[
         TextButton(
           child: Icon(Icons.more_vert, color: Theme.of(context).primaryColor),
           onPressed: ((){
               _navigationService.launchLink(
                widget.args.initialUrl,
                isExternal: true,
                title: 'Open with an External Browser?',
                description: 'You are about to open this link with an external browser.',
                buttonText: 'Yes, Go Ahead',
                closeButtonText: 'Stay Here'
                );
              
           }),
           ),
=======
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
                  description: 'You are about to open this link with an external browser.',
                  buttonText: 'Yes, Go Ahead',
                  closeButtonText: 'Stay Here'
                  );
              }),
              );
             }).toList(),
             onChanged: (_){},
         ))
>>>>>>> dc7b318f8b4690031971e13c12fb08b034916b86
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
