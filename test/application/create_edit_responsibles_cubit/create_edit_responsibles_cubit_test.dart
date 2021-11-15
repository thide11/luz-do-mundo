import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luz_do_mundo/application/create_edit_responsibles_cubit/create_edit_responsibles_cubit.dart';
import 'package:luz_do_mundo/domain/entity/responsible.dart';
import 'package:luz_do_mundo/domain/repository/responsible_repository.dart';
import 'package:mocktail/mocktail.dart';

class FakeResponsibleRepository extends Mock implements ResponsibleRepository {}
class ResponsibleFake extends Fake implements Responsible {}
void main() {
  late ResponsibleRepository _responsibleRepository;
  setUp(() {
    _responsibleRepository = FakeResponsibleRepository();
  });

  setUpAll(() {
    registerFallbackValue(ResponsibleFake());
  });

  group("Cadastro", () {
    final responsible = Responsible(
      name: "teste",
      picture: null,
      telephone: '1897877658'
    );
    blocTest<CreateEditResponsiblesCubit, CreateEditResponsiblesState>(
      "Deve ler alteracoes e cadastrar um responsável",
      build: () => CreateEditResponsiblesCubit(_responsibleRepository),
      act: (bloc) {
        bloc.load();
        bloc.onNameChanged(responsible.name);
        bloc.onTelephoneChanged(responsible.telephone);
        bloc.save();
      },
      setUp: () {
        when(() => _responsibleRepository.create(any()))
            .thenAnswer((invocation) async => "gfwegf");
      },
      verify: (_) {
        verify(() => _responsibleRepository.create(any())).called(1);
      },
      expect: () {
        return [
          EditingCreateEditResponsibles(responsible: Responsible(name: "", telephone: ''), isSaving: false),
          EditingCreateEditResponsibles(responsible: Responsible(name: responsible.name, telephone: ''), isSaving: false),
          EditingCreateEditResponsibles(responsible: Responsible(name: responsible.name, telephone: responsible.telephone), isSaving: false),
          EditingCreateEditResponsibles(responsible: Responsible(name: responsible.name, telephone: responsible.telephone), isSaving: true),
          SucessCreateEditResponsibles()
        ];
      },
    );
  });
  group("Editar", () {
    final responsible = Responsible(
      id: "massa",
      name: "teste",
      telephone: '',
      picture: null,
    );
    final newName = "testtwo";
    blocTest<CreateEditResponsiblesCubit, CreateEditResponsiblesState>(
      "Deve editar um responsável",
      build: () => CreateEditResponsiblesCubit(_responsibleRepository),
      act: (bloc) async {
        bloc.load(responsible);
        bloc.onNameChanged(newName);
        bloc.save();
      },
      setUp: () {
        when(() => _responsibleRepository.edit(any()))
            .thenAnswer((invocation) async => "gfwegf");
      },
      verify: (_) {
        verify(() => _responsibleRepository.edit(any())).called(1);
      },
      expect: () {
        return [
          EditingCreateEditResponsibles(responsible: Responsible(id: responsible.id, name: responsible.name, telephone: ''), isSaving: false),
          EditingCreateEditResponsibles(responsible: Responsible(id: responsible.id, name: newName, telephone: ''), isSaving: false),
          EditingCreateEditResponsibles(responsible: Responsible(id: responsible.id, name: newName, telephone: ''), isSaving: true),
          SucessCreateEditResponsibles()
        ];
      },
    );
  });
}
