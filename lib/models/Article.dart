import 'package:flutter/foundation.dart';
import 'package:app/models/Campaigns.dart';

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

  //List<Article> getArticlesByType(ArticleType type) {
  //  return articles.where((a) => a.getType() == type);
  //}
}

class Article {
  int id;
  String title;
  String subtitle;
  String body;
  String headerImage;
  int linkedCampaign;
  int linkedAction;
  String videoLink;
  
  String fullArticleLink;
  String linkText;
  //ArticleType type;
  bool isVideoOfTheDay;

  Article({
    @required this.id, 
    @required this.title, 
    @required this.subtitle, 
    @required this.body, 
    @required this.headerImage, 
    this.linkedCampaign, 
    this.fullArticleLink, 
    this.linkedAction, 
    this.videoLink, 
    //this.type,
    this.isVideoOfTheDay,
  });

  Article.fromJson(Map json) {
    id                = json['id'];
    title             = json['title'];
    subtitle          = json['subtitle'];
    body              = json['body'];
    headerImage       = json['header_image'];
    linkedCampaign    = json['linked_campaign'];
    linkedAction      = json['linked_action'];
    fullArticleLink   = json['full_article_link'];
    linkText          = json['link_text'];
    videoLink         = json['video_link'];
    //type            = json['type'];
    isVideoOfTheDay   = json['video_of_the_day'] ?? false;
  }
  
  Map toJson() => {
    'id': id,
    'title': title,
    'body': body,
    'header_image': headerImage,
    'campaign_id': linkedCampaign,
    'linked_action': linkedAction,
    'full_article_link': fullArticleLink,
    'video_link': videoLink,
    //'type': type,
    'video_of_the_day': videoLink,
    'link_text': linkText,
    'subtitle': subtitle,
  };

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
  String getHeaderImage() {
    return headerImage; 
  }
  String getFullArticleLink() {
    return fullArticleLink; 
  }
  String getLinkText() {
    return linkText; 
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
  //ArticleType getType() {
  //  return type;
  //}
  bool getIsVideoOfTheDay() {
    return isVideoOfTheDay;
  }
  String getCategory({Campaigns campaigns}) {
    if (linkedCampaign != null) {
      if (campaigns != null) {
        for (int i = 0; i < campaigns.activeLength(); i++) {
          if (campaigns.getActiveCampaigns()[i].getId() == linkedCampaign) {
            return campaigns.getActiveCampaigns()[i].getTitle();
          }
        }
      }
      return linkedCampaign.toString();
    }
    return "General";
  }
}
