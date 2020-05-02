import 'package:flutter/foundation.dart';

enum ArticleType {
  News,
  Video, 
  Highlight,
}

class Articles {

  List<Article> articles;

  List<Article> getArticles() {
    return articles;
  }

  List<Article> getArticlesByType(ArticleType type) {
    return articles.where((a) => a.getType() == type);
  }
}

class Article {
  int id;
  String title;
  String body;
  String headerImage;
  String fullArticleLink;
  int linkedCampaign;
  int linkedAction;
  String videoLink;
  ArticleType type;

  Article({
    @required this.id, 
    @required this.title, 
    @required this.body, 
    @required this.headerImage, 
    this.linkedCampaign, 
    this.fullArticleLink, 
    this.linkedAction, 
    this.videoLink, 
    this.type,
  });

  int getId() {
    return id; 
  }
  String getTitle() {
    return title; 
  }
  String getBody() {
    return body; 
  }
  String getHeaderImage() {
    return headerImage; 
  }
  String getFullArticleLink() {
    return fullArticleLink; 
  }
  int getLinkedCampaign() {
    return linkedCampaign; 
  }
  int getLinkedAction() {
    return linkedAction; 
  }
  String getVideoLink() {
    return videoLink; 
  }
  ArticleType getType() {
    return type;
  }
}
