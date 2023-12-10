import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/material.dart';

import 'package:nowu/assets/StyleFrom.dart';

import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/navigation_service.dart';

final NavigationService? _navigationService = locator<NavigationService>();

class InternalNotification {
  int? id;
  String? title;
  String? subtitle;
  String? body;
  String? image;

  InternalNotification({this.title, this.body, this.image, this.subtitle});

  InternalNotification.fromJson(
    Map json,
  ) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    body = json['body'];
    image = json['image'];
  }

  int? getId() {
    return id;
  }

  String? getTitle() {
    return title;
  }

  String? getSubtitle() {
    return subtitle;
  }

  String? getBody() {
    return body;
  }

  String? getImage() {
    return image;
  }

  Widget getBodyWidget(context) {
    return Markdown(
      data: body!,
      onTapLink: (String text, String? href, String title) {
        _navigationService!.launchLink(href!);
      },
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
        p: textStyleFrom(
          Theme.of(context).textTheme.bodyLarge,
          color: Colors.white,
        ),
        listBullet: textStyleFrom(
          Theme.of(context).textTheme.bodyLarge,
          color: Colors.white,
        ),
        textAlign: WrapAlignment.center,
        textScaleFactor: 1.2,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
