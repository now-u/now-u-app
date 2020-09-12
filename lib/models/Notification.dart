import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/material.dart';

class InternalNotification {
  int id;
  String title;
  String subtitle;
  String body;
  String image;

  InternalNotification({this.title, this.body, this.image, this.subtitle});
  
  InternalNotification.fromJson(
    Map json,
  ) {
    id = json["id"];
    title = json["title"];
    subtitle = json["subtitle"];
    body = json["body"];
    image = json["image"];
  }
  
  int getId() {
    return id;
  }

  String getTitle() {
    return title;
  }
  
  String getSubtitle() {
    return subtitle;
  }
  
  String getBody() {
    return body;
  }
  
  String getImage() {
    return image;
  }

  Widget getBodyWidget() {
    return MarkdownBody(data: body);
  }
}
