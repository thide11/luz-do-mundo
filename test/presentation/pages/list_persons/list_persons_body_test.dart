import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luz_do_mundo/application/core/base_crud_states.dart';
import 'package:luz_do_mundo/application/list_persons_cubit.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/presentation/pages/list_persons/list_persons_body.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/fixtures.dart';
import '../../../utils/predicates.dart';
import '../../../utils/test_scaffold.dart';

class MockListPersonsCubit extends Mock implements ListPersonsCubit {}

void main() {
  testWidgets('Deve listar as pessoas corretamente', (tester) async {
    final cubit = MockListPersonsCubit();
    final baseNeedyPerson = Fixtures.needyPerson();

    final state = LoadedBaseCrudStates(
      [
        baseNeedyPerson,
        baseNeedyPerson.copyWith(name: "Jackson", photo: AppFile(fileUrl: "https://picsum.photos/100", md5Hash: "fwefwe")),
        baseNeedyPerson.copyWith(name: "Poliana", photo: AppFile(fileUrl: "https://picsum.photos/101", md5Hash: "gheger2")),
      ],
    );
    
    whenListen(cubit, Stream.fromIterable([state]));
    when(() => cubit.state).thenReturn(state);
    when(() => cubit.close()).thenAnswer(
      (_) async => null
    );

    await tester.pumpWidget(
      TestScaffold(
        child: BlocProvider<ListPersonsCubit>(
          create: (context) => cubit,
          child: ListPersonsBody(),
        ),
      ),
    );

    state.data.forEach((person) {
      if (person.picture != null) {
        expect(
          Predicates.findAppFile(person.picture!),
          findsOneWidget,
        );
      }
      expect(
        find.text(person.name),
        findsOneWidget,
      );
    });
  });
}