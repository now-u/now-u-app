import 'package:flutter/material.dart';
import 'package:nowu/ui/views/explore/explore_page_viewmodel.dart';

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
  const CausesFilter({
    super.key,
    required this.viewModel,
  });

  final ExplorePageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'exploreCausesFilterPill',
      child: ExploreFilterChip(
        onSelected: (_) => viewModel.openCausesFilterSheet(),
        label: 'Causes',
        isSelected: viewModel.filterCauseIds.isNotEmpty,
      ),
    );
  }
}

class TimeFilter extends StatelessWidget {
  const TimeFilter({
    super.key,
    required this.viewModel,
  });

  final ExplorePageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ExploreFilterChip(
      onSelected: (_) => viewModel.openTimeBracketsFilterSheet(),
      label: 'Time',
      isSelected: viewModel.filterTimeBrackets.isNotEmpty,
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
          isSelected: viewModel.filterCompleted,
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
          isSelected: viewModel.filterRecommended,
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
          isSelected: viewModel.filterNew,
        );
  }
}
