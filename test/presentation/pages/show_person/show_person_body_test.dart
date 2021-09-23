import 'package:flutter_test/flutter_test.dart';
import 'package:luz_do_mundo/domain/entity/needy_person.dart';
import 'package:luz_do_mundo/presentation/pages/show_person/show_person_body.dart';

import '../../../utils/fixtures.dart';
import '../../../utils/predicates.dart';
import '../../../utils/test_scaffold.dart';

void main() {
  late NeedyPerson needyPerson;
  setUp(() {
    needyPerson = Fixtures.needyPerson();
  });
  testWidgets('Deve exibir todos os dados da pessoa ...', (tester) async {
    await tester.pumpWidget(TestScaffold(child: ShowPersonBody(needyPerson: needyPerson)));

    expect(
      Predicates.findAppFile(needyPerson.photo!),
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

  testWidgets('Deve exibir não informado, caso tenha um dado em branco ...', (tester) async {
    final _needyPerson = needyPerson.copyWith(adress: "");
    await tester.pumpWidget(TestScaffold(child: ShowPersonBody(needyPerson: _needyPerson)));

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