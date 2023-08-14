import 'package:nowu/assets/components/header.dart';
import 'package:flutter/material.dart';

/// Page which shows additional text information, usually as a result of
/// clicking on a question mark in the app.
class InfoPageArgumnets {
  final String? title;
  final String? body;

  InfoPageArgumnets({required this.title, required this.body});

  String? getTitle() {
    return title;
  }

  String? getBody() {
    return body;
  }
}

class InfoPage extends StatelessWidget {
  final InfoPageArgumnets args;

  InfoPage(this.args);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          PageHeader(
            title: args.getTitle(),
            backButton: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text(
              args.getBody()!.replaceAll('\n', '\n\n'),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
