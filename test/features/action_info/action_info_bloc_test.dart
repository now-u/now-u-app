import 'package:bloc_test/bloc_test.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/ui/views/action_info/bloc/action_info_bloc.dart';
import 'package:nowu/ui/views/action_info/bloc/action_info_state.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

import '../../factories/action_factory.dart';

class MockCausesService extends Mock implements CausesService {}

void main() {
  final causesService = MockCausesService();
  final action = ActionFactory().generate();

  ActionInfoBloc buildBloc() {
    return ActionInfoBloc(
      causesService: causesService,
      actionId: 123,
    );
  }

  setUp(() {
    when(() => causesService.getAction(any())).thenAnswer((_) async => action);
  });

  group(ActionInfoBloc, () {
    test('Initial state is loading', () {
      final bloc = buildBloc();
      expect(bloc.state, const ActionInfoStateInitial());
    });

    blocTest<ActionInfoBloc, ActionInfoState>(
      'fetches action from causes service on fetchAction',
      build: () => buildBloc(),
      act: (cubit) => cubit.fetchAction(),
      expect: () => [
        ActionInfoStateSuccess(
          action: action,
          statusUpdateState: const ActionInfoStatusUpdateState.initial(),
        ),
      ],
      verify: (_) {
        verify(() => causesService.getAction(123)).called(1);
      },
    );
  });
}
