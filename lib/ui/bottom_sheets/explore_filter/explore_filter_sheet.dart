import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ExploreFilterSheetOption<T> {
  final String title;
  final T value;
  final bool isSelected;

  ExploreFilterSheetOption({
    required this.title,
    required this.value,
    required this.isSelected,
  });
}

// class ExploreFilterSheetArgs<T> {
//   final String filterName;
//   final List<ExploreFilterSheetOption<T>> options;
//   final Function(T) onSelectOption;
//   final Function()? onClosed;
//
//   ExploreFilterSheetArgs({
//     required this.filterName,
//     required this.options,
//     required this.onSelectOption,
//     this.onClosed,
//   });
// }

class ExploreFilterSheet<T> extends StatelessWidget {
  final String filterName;
  final List<ExploreFilterSheetOption<T>> options;
  final Function(T) onSelectOption;
  final Function()? onClosed;

  const ExploreFilterSheet({
    Key? key,
    required this.filterName,
    required this.options,
    required this.onSelectOption,
    this.onClosed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            filterName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          ...options.map(
            (option) => Material(
              color: Colors.white,
              child: InkWell(
                onTap: () => onSelectOption(option.value),
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
                      if (option.isSelected)
                        Icon(
                          Icons.check,
                          color: Theme.of(context).primaryColor,
                        ),
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
              onPressed: () => context.router.pop(),
              child: const Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }
}
