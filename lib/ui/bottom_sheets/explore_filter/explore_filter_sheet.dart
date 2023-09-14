import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'explore_filter_sheet_model.dart';

class ExploreFilterSheetOption<T> {
  final String title;
  final T value;

  ExploreFilterSheetOption({
    required this.title,
    required this.value,
  });
}

class ExploreFilterSheetData<T> {
  final String filterName;
  final List<ExploreFilterSheetOption<T>> options;
  final Set<T> initialSelectedValues;

  ExploreFilterSheetData({
    required this.filterName,
    required this.options,
    required this.initialSelectedValues,
  });
}

class ExploreFilterSheet extends StackedView<ExploreFilterSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;

  const ExploreFilterSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ExploreFilterSheetModel viewModel,
    Widget? child,
  ) {
    ExploreFilterSheetData data = request.data!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            data.filterName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          ...data.options.map(
            (option) => Material(
              color: Colors.white,
              child: InkWell(
                onTap: () => viewModel.toggleSelectOption(option),
                child: Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          option.title,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      if (viewModel.isSelected(option))
                        Icon(Icons.check,
                            color: Theme.of(context).primaryColor,),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                completer!(SheetResponse(
                    confirmed: true, data: viewModel.selectedOptionValues,),);
              },
              child: const Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  ExploreFilterSheetModel viewModelBuilder(BuildContext context) =>
      ExploreFilterSheetModel(
          selectedOptionValues: request.data!.initialSelectedValues,);
}
