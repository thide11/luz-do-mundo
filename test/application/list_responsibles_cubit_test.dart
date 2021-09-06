import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luz_do_mundo/application/core/base_crud_states.dart';
import 'package:luz_do_mundo/application/list_responsibles_cubit.dart';
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

  final stream = StreamController<List<Responsible>>();
  final responsibles = [
    ResponsibleFake(),
    ResponsibleFake()
  ];

  blocTest<ListResponsiblesCubit, BaseCrudStates<List<Responsible>>>(
      "Deve listar os responsáveis",
      build: () => ListResponsiblesCubit(_responsibleRepository),
      act: (bloc) {
        bloc.load();
      },
      setUp: () {
        when(() => _responsibleRepository.listStream())
            .thenAnswer((invocation) => stream.stream);
        stream.add(responsibles);
      },
      verify: (_) {
        verify(() => _responsibleRepository.listStream()).called(1);
      },
      expect: () {
        return [
          LoadingBaseCrudStates<List<Responsible>>(),
          LoadedBaseCrudStates<List<Responsible>>(responsibles)
        ];
      },
      tearDown: () {
        stream.close();
      }
    );
}