import 'package:app/viewmodels/base_model.dart';
import 'package:app/pages/explore/ExploreSection.dart';
import 'package:app/pages/explore/ExploreFilter.dart';
import 'package:app/models/Explorable.dart';

// TODO rename to explore *section* view model
class ExplorePageViewModel<ExplorableType extends Explorable> extends BaseModel {

  final ExploreFilter? filter;
  final Function _fetchTiles;
  bool isLoading = true;
  bool error = false;

  List<ExplorableType>? tiles; 

  ExplorePageViewModel({required this.filter, required Function fetchTiles}) :
    _fetchTiles = fetchTiles;

  void selectFilterOption(ExploreFilterOption filterOption) {
    filterOption.toggleSelect();
    fetchTiles();
  }

  void fetchTiles() async {
    setBusy(true);
    this.tiles = await _fetchTiles(params: filter?.toJson());
    setBusy(false);
  }
}
