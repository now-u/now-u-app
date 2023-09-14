import 'package:nowu/ui/bottom_sheets/explore_filter/explore_filter_sheet.dart';
import 'package:stacked/stacked.dart';

class ExploreFilterSheetModel extends BaseViewModel {
  Set<dynamic> _selectedOptionValues = Set();
  Set<dynamic> get selectedOptionValues => _selectedOptionValues;

  ExploreFilterSheetModel({
    required Set<dynamic> selectedOptionValues,
  }) : this._selectedOptionValues = selectedOptionValues;

  bool isSelected(ExploreFilterSheetOption option) {
    return _selectedOptionValues.contains(option.value);
  }

  void toggleSelectOption(ExploreFilterSheetOption option) {
    if (isSelected(option)) {
      _selectedOptionValues.remove(option.value);
    } else {
      _selectedOptionValues.add(option.value);
    }
    notifyListeners();
  }
}
