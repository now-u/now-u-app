import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:app/assets/components/customAppBar.dart';
import 'package:stacked/stacked.dart';
import 'package:app/viewmodels/web_view_model.dart';


class WebViewArguments {
  final String initialUrl;
  WebViewArguments(this.initialUrl);
}

class WebViewPage extends StatelessWidget {
  final WebViewArguments args;
  WebViewPage(this.args);
  
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WebViewViewModel>.reactive(
       viewModelBuilder: () => WebViewViewModel(args.initialUrl),
       builder: (context, model, child) {
         return Scaffold(
           appBar: customAppBar(
             context: context,
             actions: <Widget>[
             TextButton(
              child: Icon(Icons.launch, color: Theme.of(context).primaryColor),
               onPressed: ((){        
                model.launchExternal();
               }),
              ),
             ]
             ),
             body: SafeArea(
               child: WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: args.initialUrl,
                  onWebResourceError: (error) {
                    model.onWebError();
                  },
                ),
               ),
         );
       }
       );
  }
}
