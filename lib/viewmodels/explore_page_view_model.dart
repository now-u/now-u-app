import 'dart:collection';

import 'package:app/pages/explore/ExplorePage.dart';
import 'package:app/pages/explore/ExploreSection.dart';
import 'package:app/viewmodels/base_model.dart';

class ExplorePageViewModel extends BaseModel {
  List<ExploreSection> sections;
  String title;

  final Queue<ExplorePage> previousPages = Queue();

  ExplorePageViewModel(this.sections, this.title);

  void update({List<ExploreSection>? sections, String? title, bool saveHistory = true}) {
    if (saveHistory) {
      previousPages.addLast(ExplorePage(sections: this.sections, title: this.title));
    }
    this.sections = sections ?? this.sections;
    this.title = title ?? this.title;
    notifyListeners();
  }

  bool get canBack => previousPages.length != 0;

  void back() {
    if (previousPages.length == 0) {
      return;
    }
    ExplorePage page = previousPages.last; 
    previousPages.removeLast();
    update(sections: page.sections, title: page.title, saveHistory: false);
  }
}
