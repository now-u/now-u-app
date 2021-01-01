import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:app/assets/components/customAppBar.dart';

import 'package:stacked/stacked.dart';
import 'package:app/viewmodels/web_view_model.dart';

class WebViewArgumnets {
  final String initialUrl;

  WebViewArgumnets(this.initialUrl);
}

class WebViewPage extends StatelessWidget {
  final WebViewArgumnets args;
  WebViewPage(this.args);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backButtonText: "Back",
        context: context,
      ),
      body: SafeArea(
        child: ViewModelBuilder<WebViewViewModel>.reactive(
            viewModelBuilder: () => WebViewViewModel(),
            builder: (context, model, child) {
              return WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: args.initialUrl,
                onWebResourceError: (error) {
                  model.onWebError(args.initialUrl);
                },
              );
            }
          )
      ),
    );
  }
}
