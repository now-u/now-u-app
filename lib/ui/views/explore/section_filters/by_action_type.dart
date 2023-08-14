import 'package:collection/collection.dart';
import 'package:nowu/models/Action.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/views/explore/explore_page_definition.dart';

class ByActionTypeFilter
    extends ExploreFilterArgs<ActionSearchFilter, Iterable<ActionTypeEnum>> {
  ByActionTypeFilter() : super(isMulti: false);

  @override
  getOptions() async {
    return actionTypes.map(
      (type) => ExploreFilterOptionArgs(
        displayName: type.name,
        parameterValue: type.subTypes,
      ),
    );
  }

  @override
  ActionSearchFilter optionsToFilter(selectedOptions) {
    return ActionSearchFilter(
      types: selectedOptions.map((option) => option.parameterValue).flattened,
    );
  }
}
