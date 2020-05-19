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

  Article.fromJson(Map json) {
    id              = json['id'];
    title           = json['title'];
    body            = json['body'];
    headerImage     = json['header_image'];
    linkedCampaign  = json['linked_campaign'];
    linkedAction    = json['linked_action'];
    fullArticleLink = json['full_article_link'];
    videoLink       = json['video_link'];
    type            = json['type'];
  }
  
  Map toJson() => {
    'id': id,
    'title': title,
    'body': body,
    'header_image': headerImage,
    'linked_campaign': linkedCampaign,
    'linked_action': linkedAction,
    'full_article_link': fullArticleLink,
    'video_link': videoLink,
    'type': type,
  };

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
  String getCategory() {
    if (linkedCampaign != null) {
      return linkedCampaign.toString();
    }
    return "General";
  }
}
