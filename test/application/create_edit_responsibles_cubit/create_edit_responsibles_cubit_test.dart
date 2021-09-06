import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luz_do_mundo/application/create_edit_responsibles_cubit/create_edit_responsibles_cubit.dart';
import 'package:luz_do_mundo/domain/entity/responsible.dart';
import 'package:luz_do_mundo/domain/repository/responsible_repository.dart';
import 'package:luz_do_mundo/infrastructure/data/responsible_dto.dart';
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
    );
    blocTest<CreateEditResponsiblesCubit, CreateEditResponsiblesState>(
      "Deve cadastrar um responsável",
      build: () => CreateEditResponsiblesCubit(_responsibleRepository),
      act: (bloc) {
        bloc.load();
        bloc.onNameChanged(responsible.name);
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
          EditingCreateEditResponsibles(responsible: ResponsibleDto(name: ""), isSaving: false),
          EditingCreateEditResponsibles(responsible: ResponsibleDto(name: responsible.name), isSaving: false),
          EditingCreateEditResponsibles(responsible: ResponsibleDto(name: responsible.name), isSaving: true),
          SucessCreateEditResponsibles()
        ];
      },
    );
  });
  group("Editar", () {
    final responsible = Responsible(
      id: "massa",
      name: "teste",
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
          EditingCreateEditResponsibles(responsible: ResponsibleDto(id: responsible.id, name: responsible.name), isSaving: false),
          EditingCreateEditResponsibles(responsible: ResponsibleDto(id: responsible.id, name: newName), isSaving: false),
          EditingCreateEditResponsibles(responsible: ResponsibleDto(id: responsible.id, name: newName), isSaving: true),
          SucessCreateEditResponsibles()
        ];
      },
    );
  });
}
