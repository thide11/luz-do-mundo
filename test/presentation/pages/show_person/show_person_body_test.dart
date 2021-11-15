import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luz_do_mundo/application/core/base_crud_states.dart';
import 'package:luz_do_mundo/application/show_person/show_person_cubit.dart';
import 'package:luz_do_mundo/domain/entity/needy_person.dart';
import 'package:luz_do_mundo/presentation/pages/show_person/show_person_body.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/fixtures.dart';
import '../../../utils/predicates.dart';
import '../../../utils/test_scaffold.dart';

class MockShowPersonCubit extends MockCubit<BaseCrudStates<NeedyPerson>>
    implements ShowPersonCubit {}

void main() {
  late NeedyPerson needyPerson;
  late ShowPersonCubit showPersonCubit;
  setUp(() {
    showPersonCubit = MockShowPersonCubit();
    needyPerson = Fixtures.needyPerson();
  });
  setUpAll(() {
    registerFallbackValue(LoadingBaseCrudStates<NeedyPerson>());
  });
  testWidgets('Deve exibir todos os dados da pessoa ...', (tester) async {
    when(() => showPersonCubit.state)
        .thenReturn(LoadedBaseCrudStates(needyPerson));
    await tester.pumpWidget(TestScaffold(
      child: BlocProvider(
        create: (context) => showPersonCubit,
        child: ShowPersonBody(),
      ),
    ));

    expect(
      Predicates.findAppFile(needyPerson.picture!),
      findsOneWidget,
    );
    expect(
      find.text("Nome: ${needyPerson.name}"),
      findsOneWidget,
    );
    expect(
      find.text("Data de nascimento: 30/09/2000"),
      findsOneWidget,
    );

    expect(
      find.text("Endereço: ${needyPerson.adress}"),
      findsOneWidget,
    );

    expect(
      find.text("CPF: ${needyPerson.cpf}"),
      findsOneWidget,
    );

    expect(
      find.text("RG: ${needyPerson.rg}"),
      findsOneWidget,
    );
  });

  testWidgets('Deve exibir não informado, caso tenha um dado em branco ...',
      (tester) async {
    when(() => showPersonCubit.state).thenReturn(
      LoadedBaseCrudStates(
        needyPerson.copyWith(adress: ''),
      ),
    );
    final _needyPerson = needyPerson.copyWith(adress: "");
    await tester.pumpWidget(TestScaffold(
      child: BlocProvider(
        create: (context) => showPersonCubit..load(),
        child: ShowPersonBody(),
      ),
    ));

    expect(
      find.text("Nome: ${_needyPerson.name}"),
      findsOneWidget,
    );
    expect(
      find.text("Endereço: Não informado"),
      findsOneWidget,
    );
  });
}
