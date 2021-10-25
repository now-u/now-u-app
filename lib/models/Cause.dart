class ListCause {
  int? id;
  String? title;
  String? icon;
  String? description;
  bool? selected;

  ListCause({this.id, this.title, this.icon, this.description, this.selected});
  
  ListCause.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    title = json['title'],
    icon = json['icon'],
    description = json['description'],
    selected = json['selected'];
}

class Cause extends ListCause {
  String? headerImage;
  List<int>? actions;

  Cause({this.headerImage, this.actions, int? id, String? title, String? icon, String? description, bool? selected})
      : super(id: id, title: title, icon: icon, description: description, selected: selected);

  Cause.fromJson(Map<String, dynamic> json): 
    headerImage = json['headerImage'],
    actions = json['actions'],
    super.fromJson(json);
}
