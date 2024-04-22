import 'package:nowu/app/app.bottomsheets.dart';
import 'package:nowu/router.dart';
import 'package:nowu/ui/bottom_sheets/explore_filter/explore_filter_sheet.dart';
import 'package:stacked_services/stacked_services.dart';
export 'package:stacked_services/stacked_services.dart' show BottomSheetService;

extension BottomSheetServiceExtension on BottomSheetService {
  Future<Set<T>?> showExploreFilterSheet<T>(
    ExploreFilterSheetData<T> data,
  ) async {
    final response = await showCustomSheet<dynamic, ExploreFilterSheetData<T>>(
      variant: BottomSheetType.exploreFilter,
      data: data,
	  useRootNavigator: true,
    );
    if (!(response?.confirmed == true)) {
      return null;
    }
    return response!.data!.cast<T>();
  }
}
