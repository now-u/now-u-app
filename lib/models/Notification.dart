class Notification {
  String _title;
  String _body;
  String _image;
  
  Notification.fromJson(
    Map json,
  ) {
    _title = json["title"];
    _body = json["body"];
    _image = json["image"];
  }

  String getTitle() {
    return _title;
  }
  
  String getBody() {
    return _body;
  }
  
  String getImage() {
    return _image;
  }
}
