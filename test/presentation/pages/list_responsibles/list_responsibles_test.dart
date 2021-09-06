import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luz_do_mundo/application/core/base_crud_states.dart';
import 'package:luz_do_mundo/application/list_responsibles_cubit.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/domain/entity/responsible.dart';
import 'package:luz_do_mundo/presentation/pages/list_responsibles/list_responsibles_body.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/predicates.dart';
import '../../../utils/test_scaffold.dart';

class MockListResponsiblesCubit
    extends MockCubit<BaseCrudStates<List<Responsible>>>
    implements ListResponsiblesCubit {}

void main() {
  late ListResponsiblesCubit cubit;
  setUpAll(() {
    registerFallbackValue<BaseCrudStates<List<Responsible>>>(
      EmptyBaseCrudStates(),
    );
  });

  setUp(() {
    cubit = MockListResponsiblesCubit();
  });
  testWidgets('Deve listar os responsáveis ...', (tester) async {
    final rogerio = Responsible(
      name: "Rogérin",
      picture: AppFile(fileUrl: "https://fotolegal.com", md5Hash: 'gwegw'),
    );
    final alberto = Responsible(
      name: "Alberto",
      picture: AppFile(fileUrl: "https://example.com", md5Hash: 'has'),
    );

    final state = LoadedBaseCrudStates<List<Responsible>>([
      rogerio,
      alberto,
    ]);
    when(() => cubit.state).thenReturn(state);
    final widget = TestScaffold(
      child: BlocProvider<ListResponsiblesCubit>(
        create: (_) => cubit,
        child: ListResponsiblesBody(),
      ),
    );
    await tester.pumpWidget(widget);

    state.data.forEach((responsible) {
      if (responsible.picture != null) {
        expect(
          Predicates.findAppFile(responsible.picture!),
          findsOneWidget,
        );
      }
      expect(
        find.text(responsible.name),
        findsOneWidget,
      );
    });
  });
}
