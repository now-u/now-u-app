import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/models/time.dart';
import 'package:nowu/ui/bottom_sheets/explore_filter/explore_filter_sheet.dart';
import 'package:nowu/ui/views/explore/bloc/explore_state.dart';
import 'package:nowu/ui/views/explore/explore_page_viewmodel.dart';
import 'package:tuple/tuple.dart';

import '../bloc/explore_bloc.dart';

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
    return Hero(
      tag: 'exploreCausesFilterPill',
      child: BlocBuilder<ExploreBloc, ExploreState>(
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
    return BlocBuilder<ExploreBloc, ExploreState>(
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
                    isSelected:
                        state.filterState.filterTimeBrackets.contains(value),
                  );
                },
              ).toList(),
              onSelectOption: (_) => print('TODO'),
            ),
          ),
          label: 'Time',
          isSelected: state.filterState.filterTimeBrackets.isNotEmpty,
        );
      },
    );
  }
}

class CompletedFilter extends StatelessWidget {
  const CompletedFilter({
    super.key,
    required this.viewModel,
  });

  final ExplorePageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ExploreFilterChip(
      onSelected: (_) => viewModel.toggleFilterCompleted(),
      label: 'Completed',
      isSelected: viewModel.filterData.filterCompleted,
    );
  }
}

class RecommendedFilter extends StatelessWidget {
  const RecommendedFilter({
    super.key,
    required this.viewModel,
  });

  final ExplorePageViewModel viewModel;

  // TODO Fix - Not implemeneted - suggested not serializer on server side/filterable
  @override
  Widget build(BuildContext context) {
    return ExploreFilterChip(
      onSelected: (_) => viewModel.toggleFilterRecommended(),
      label: 'Recommended',
      isSelected: viewModel.filterData.filterRecommended,
    );
  }
}

class NewFilter extends StatelessWidget {
  const NewFilter({
    super.key,
    required this.viewModel,
  });

  final ExplorePageViewModel viewModel;

  // TODO Fix - Not implemeneted - how get release date? Can api return that?
  @override
  Widget build(BuildContext context) {
    return ExploreFilterChip(
      onSelected: (_) => viewModel.toggleFilterNew(),
      label: 'New',
      isSelected: viewModel.filterData.filterNew,
    );
  }
}
