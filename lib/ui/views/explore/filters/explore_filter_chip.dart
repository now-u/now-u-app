import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/models/Action.dart';
import 'package:nowu/models/time.dart';
import 'package:nowu/ui/bottom_sheets/explore_filter/explore_filter_sheet.dart';
import 'package:tuple/tuple.dart';

import '../bloc/explore_filter_bloc.dart';
import '../bloc/explore_filter_state.dart';

class ExploreFilterChip extends StatelessWidget {
  final ValueChanged<bool> onSelected;
  final String label;
  final bool isSelected;

  const ExploreFilterChip({
    super.key,
    required this.onSelected,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      onSelected: onSelected,
      selectedColor: Theme.of(context).colorScheme.primary,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.23),
      label: Text(
        label,
        style: const TextStyle(fontSize: 12),
      ),
      selected: isSelected,
    );
  }
}

class CausesFilter extends StatelessWidget {
  const CausesFilter({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO Is this hero doing anything? - If no remove, if yes can we add to all other filters?
    return Hero(
      tag: 'exploreCausesFilterPill',
      child: BlocBuilder<ExploreFilterBloc, ExploreFilterState>(
        builder: (context, state) {
          return ExploreFilterChip(
            onSelected: (_) => showDialog(
              context: context,
              // TODO Fix
              builder: (context) => ExploreFilterSheet(
                filterName: 'Causes',
                // options: options?.toList() ?? [],
                // TODO Pull causes out of causes bloc!
                options: [],
                onSelectOption: (_) => print('TODO'),
              ),
            ),
            label: 'Causes',
            // TODO Pull causes out of causes bloc!
            // isSelected: state.filterState.filterCauseIds.isNotEmpty,
            isSelected: false,
          );
        },
      ),
    );
  }
}

class TimeFilter extends StatelessWidget {
  const TimeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreFilterBloc, ExploreFilterState>(
      builder: (context, state) {
        return ExploreFilterChip(
          onSelected: (_) => showDialog(
            context: context,
            // TODO Fix
            builder: (context) => ExploreFilterSheet(
              filterName: 'Times',
              // options: options?.toList() ?? [],
              // TODO Pull causes out of causes bloc!
              options: timeBrackets.map(
                (timeBracket) {
                  final value =
                      Tuple2(timeBracket.minTime, timeBracket.maxTime);
                  return ExploreFilterSheetOption(
                    title: timeBracket.text,
                    value: value,
                    isSelected: state.filterTimeBrackets.contains(value),
                  );
                },
              ).toList(),
              onSelectOption: (option) {
                final filterTimeBrackets = state.filterTimeBrackets;
                if (filterTimeBrackets.contains(option)) {
                  filterTimeBrackets.remove(option);
                } else {
                  filterTimeBrackets.add(option);
                }
                context.read<ExploreFilterBloc>().updateFilter(
                      state.copyWith(
                        filterTimeBrackets: filterTimeBrackets,
                      ),
                    );
              },
            ),
          ),
          label: 'Time',
          isSelected: state.filterTimeBrackets.isNotEmpty,
        );
      },
    );
  }
}

class ActionTypeFilter extends StatelessWidget {
  const ActionTypeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreFilterBloc, ExploreFilterState>(
      builder: (context, state) {
        return ExploreFilterChip(
          onSelected: (_) => showDialog(
            context: context,
            // TODO Fix
            builder: (context) => ExploreFilterSheet(
              filterName: 'Action type',
              options: actionTypes
                  .map(
                    (type) => ExploreFilterSheetOption(
                      title: type.name,
                      value: type,
                      isSelected: state.filterActionTypes.contains(type.name),
                    ),
                  )
                  .toList(),
              onSelectOption: (option) {
                final filterActionTypes = state.filterActionTypes;

                // TODO This is nonsense, currently we have an enum for the subtypes
                // but only expose the 4 parent types in the app.
                option.subTypes.forEach((subType) {
                  if (filterActionTypes.contains(subType)) {
                    filterActionTypes.remove(subType);
                  } else {
                    filterActionTypes.add(subType);
                  }
                });
                context.read<ExploreFilterBloc>().updateFilter(
                      state.copyWith(
                        filterActionTypes: filterActionTypes,
                      ),
                    );
              },
            ),
          ),
          label: 'Type',
          isSelected: state.filterActionTypes.isNotEmpty,
        );
      },
    );
  }
}

class CompletedFilter extends StatelessWidget {
  const CompletedFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreFilterBloc, ExploreFilterState>(
      builder: (context, state) {
        return ExploreFilterChip(
          onSelected: (_) => context.read<ExploreFilterBloc>().updateFilter(
                state.copyWith(filterCompleted: !state.filterCompleted),
              ),
          label: 'Completed',
          isSelected: state.filterCompleted,
        );
      },
    );
  }
}

class RecommendedFilter extends StatelessWidget {
  const RecommendedFilter({super.key});

  // TODO Fix - Not implemeneted - suggested not serializer on server side/filterable
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreFilterBloc, ExploreFilterState>(
      builder: (context, state) {
        return ExploreFilterChip(
          onSelected: (_) => context.read<ExploreFilterBloc>().updateFilter(
                state.copyWith(filterRecommended: !state.filterRecommended),
              ),
          label: 'Recommended',
          isSelected: state.filterRecommended,
        );
      },
    );
  }
}

class NewFilter extends StatelessWidget {
  const NewFilter({
    super.key,
  });

  // TODO Fix - Not implemeneted - how get release date? Can api return that?
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreFilterBloc, ExploreFilterState>(
      builder: (context, state) {
        return ExploreFilterChip(
          onSelected: (_) => context
              .read<ExploreFilterBloc>()
              .updateFilter(state.copyWith(filterNew: !state.filterNew)),
          label: 'New',
          isSelected: state.filterNew,
        );
      },
    );
  }
}
