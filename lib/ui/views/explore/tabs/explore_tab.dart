import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/models/exploreable.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_bloc.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_state.dart';
import 'package:nowu/ui/views/explore/bloc/tabs/explore_tab_bloc.dart';
import 'package:nowu/ui/views/explore/filters/explore_filter_chip.dart';

import '../../../paging/paging_state.dart';
import 'filters_container.dart';

abstract class ExploreTab<T extends Explorable> extends StatelessWidget {
  ExploreTabBloc<T> createBloc(BuildContext context);
  // TODO make not a function
  List<FilterConfig> buildFilterChips();
  Widget itemBuilder(T data);

  const ExploreTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO Should this be in a bloc builder instead? Kinda confused
    return BlocProvider(
      create: (context) {
        final filterState = context.read<ExploreFilterBloc>().state;
        return createBloc(context)..search(filterState);
      },
      child: BlocListener<ExploreFilterBloc, ExploreFilterState>(
        listener: (context, state) {
          context.read<ExploreTabBloc<T>>().search(state);
        },
        child: BlocBuilder<ExploreTabBloc<T>, ExploreTabState<T>>(
          builder: (context, state) {
            switch (state.data) {
              case InitialLoading():
                return const Center(child: const CircularProgressIndicator());
              case Data(:final items, :final isLoadingMore):
                if (items.isEmpty) {
                  return ListView(
                    children: [
                      FiltersContainer(filterChips: buildFilterChips()),
                      const Center(child: Text('No results for search')),
                    ],
                  );
                }

                final itemCount = items.length + (isLoadingMore ? 2 : 1);
                return ListView.builder(
                  // +1 for the filter chips, +1 for the loading indicator if state is LoadingMore
                  itemCount: itemCount,
                  itemBuilder: (BuildContext context, int index) {
                    // TODO This keeps being called at the wrong moment when we have short result lists e.g. completed + type
                    // if (state.data is Data && index == itemCount - 1 && isLoadingMore == false) {
                    //   context
                    //       .read<ExploreTabBloc<TData>>()
                    //       .search(context.read<ExploreFilterBloc>().state, extendCurrentSearch: true);
                    // }

                    if (index == 0) {
                      return FiltersContainer(filterChips: buildFilterChips());
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
                        // TODO Find out why casting is required!!
                        child: itemBuilder((items as List<T>).toList()[index - 1]),
                      );
                    }
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
