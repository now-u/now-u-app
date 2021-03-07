class Offer {
  int _id;
  String _title;
  String _description;
  String _link;

  Offer({id, title, description, link}) {
    _id = id;
    _title = title;
    _description = description;
    _link = link;
  }

  int getId() {
    return _id;
  }

  String getTitle() {
    return _title;
  }

  String getDescription() {
    return _description;
  }

  String getLink() {
    return _link;
  }
}
