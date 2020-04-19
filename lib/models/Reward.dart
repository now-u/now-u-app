class Reward {
  int _id;
  String _title;
  String _description;
  bool _completed;

  Reward({id, title, description, completed}) {
    _id = id;
    _title = title;
    _description = description;
    _completed = completed;
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
  bool getCompleted() {
    return _completed;
  }
}
