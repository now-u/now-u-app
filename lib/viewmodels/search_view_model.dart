import 'package:flutter/widgets.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/models/Action.dart';
import 'package:nowu/pages/action/ActionInfo.dart';
import 'package:nowu/routes.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/viewmodels/base_model.dart';

class SearchViewModel extends BaseModel {
  SearchService _searchService = locator<SearchService>();
  NavigationService _navigationService = locator<NavigationService>();

  String get searchValue => _searchValue;
  String _searchValue = "";
  List<ListAction> searchResult = [];

  void updateSearchValue(String value) {
    _searchValue = value;
    search();
  }

  void search() async {
    searchResult = await _searchService.searchActions(filter: ActionSearchFilter(query: searchValue.toString()));
    notifyListeners();
  }

  void navigateToResult(int resultId) {
    print("Clicking on thing");
    _navigationService.navigateTo(Routes.actionInfo,
        arguments: ActionInfoArguments(actionId: resultId));
  }

  void navigateBack() {
    print("Going back");
    _navigationService.goBack();
  }
}
