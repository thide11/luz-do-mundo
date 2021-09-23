import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luz_do_mundo/application/core/base_crud_states.dart';
import 'package:luz_do_mundo/application/list_persons_cubit.dart';
import 'package:luz_do_mundo/domain/entity/needy_person.dart';
import 'package:luz_do_mundo/domain/repository/person_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../utils/fixtures.dart';

class MockPersonRepository extends Mock implements PersonRepository {}

void main() {
  final _personRepository = MockPersonRepository();
  late StreamController<List<NeedyPerson>> _streamController;

  setUp(() {
    _streamController = StreamController<List<NeedyPerson>>();
    when(() => _personRepository.listStream()).thenAnswer((invocation) => _streamController.stream);
  });

  tearDownAll(() => {
    _streamController.close()
  });

  final needyPersonsList = [
    Fixtures.needyPerson(),
  ];
  final state = LoadedBaseCrudStates(needyPersonsList);

  blocTest<ListPersonsCubit, BaseCrudStates>(
    "Deve testar a listagem de pessoas", 
    build: () => ListPersonsCubit(_personRepository),
    act: (cubit) {
      _streamController.add(needyPersonsList);
      cubit.load();
    },
    expect: () => [
      LoadingBaseCrudStates<List<NeedyPerson>>(),
      state
    ],
  );

  group("Envolvendo filtragem", () {
    final _streamFilterController = StreamController<List<NeedyPerson>>();

    tearDownAll(() => {
      _streamFilterController.close()
    });

    when(() => _personRepository.listStreamFilterByName("Roberto")).thenAnswer((invocation) => _streamFilterController.stream);
    blocTest<ListPersonsCubit, BaseCrudStates>(
      "Deve testar a listagem com filtragem de pessoas", 
      build: () => ListPersonsCubit(_personRepository),
      act: (cubit) async{
        cubit.load();
        _streamController.add(needyPersonsList);
        await Future.delayed(Duration(milliseconds: 10));
        cubit.onFilterChanged("Roberto");
        _streamFilterController.add([]);
      },
      expect: () => [
        LoadingBaseCrudStates<List<NeedyPerson>>(),
        state,
        LoadedBaseCrudStates<List<NeedyPerson>>([]),
      ],
    );

  });

}