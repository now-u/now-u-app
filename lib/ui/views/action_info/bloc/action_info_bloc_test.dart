import 'package:nowu/services/causes_service.dart';
import 'package:nowu/ui/views/action_info/bloc/action_info_bloc.dart';
import 'package:nowu/ui/views/action_info/bloc/action_info_state.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class MockCausesService extends Mock implements CausesService {}

void main() {
  final causesService = MockCausesService();

  ActionInfoBloc buildBloc() {
    return ActionInfoBloc(
      causesService: causesService,
      actionId: 123,
    );
  }

  group(ActionInfoBloc, () {
    test('Initial state is loading', () {
	  final bloc = buildBloc();
	  expect(bloc.state, const ActionInfoStateInitial());
	});
  });
}
