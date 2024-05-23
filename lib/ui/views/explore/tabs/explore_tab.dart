import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_bloc.dart';
import 'package:nowu/ui/views/explore/bloc/tabs/explore_tab_bloc.dart';

import '../../../paging/paging_state.dart';
import 'filters_container.dart';

class ExploreTab<TData> extends StatelessWidget {
  final Iterable<Widget> filterChips;
  final Function(TData) itemBuilder;
  final ExploreTabBloc<TData> Function(BuildContext context) createBloc;

  const ExploreTab({
    required this.filterChips,
    required this.itemBuilder,
    required this.createBloc,
  });

  @override
  Widget build(BuildContext context) {
    // TODO Should this be in a bloc builder instead? Kinda confused
    final filterState = context.read<ExploreFilterBloc>().state;
    return BlocProvider(
      create: (context) => createBloc(context)..search(filterState),
      child: BlocBuilder<ExploreTabBloc<TData>, ExploreTabState<TData>>(
        builder: (context, state) {
          switch (state.data) {
            case InitialLoading():
              return const Center(child: const CircularProgressIndicator());
            case Data(:final items, :final isLoadingMore):
              if (items.isEmpty) {
                return ListView(
                  children: [
                    FiltersContainer(filterChips: filterChips),
                    const Center(child: Text('No results for search')),
                  ],
                );
              }

              final itemCount = items.length + (isLoadingMore ? 2 : 1);
              return ListView.builder(
                // +1 for the filter chips, +1 for the loading indicator if state is LoadingMore
                itemCount: itemCount,
                itemBuilder: (BuildContext context, int index) {
                  if (state.data is Data && index == itemCount - 1) {
                    context.read<ExploreTabBloc<TData>>().search(filterState);
                  }

                  if (index == 0) {
                    return FiltersContainer(filterChips: filterChips);
                  } else if (state is InitialLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (isLoadingMore && index == itemCount - 1) {
                    return Container(
                      height: 60,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: itemBuilder(items.toList()[index - 1]),
                    );
                  }
                },
              );
          }
        },
      ),
    );
  }
}
