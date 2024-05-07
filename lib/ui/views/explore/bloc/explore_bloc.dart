import 'package:flutter_bloc/flutter_bloc.dart';

import 'explore_event.dart';
import 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
	ExploreBloc() : super(ExploreState());
}
