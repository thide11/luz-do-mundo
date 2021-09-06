
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luz_do_mundo/application/create_edit_responsibles_cubit/create_edit_responsibles_cubit.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/infrastructure/data/responsible_dto.dart';
import 'package:luz_do_mundo/presentation/pages/create_edit_responsibles/create_edit_responsible_body.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/test_scaffold.dart';

class MockCreateEditResponsiblesCubit
    extends MockCubit<CreateEditResponsiblesState>
    implements CreateEditResponsiblesCubit {}

void main() {
  late CreateEditResponsiblesCubit cubit;
  setUpAll(() {
    registerFallbackValue<CreateEditResponsiblesState>(
      EmptyCreateEditResponsibles(),
    );
  });

  setUp(() {
    cubit = MockCreateEditResponsiblesCubit();
  });

  testWidgets('Deve inserir nome no formulário', (tester) async {
    when(() => cubit.state).thenReturn(
      EditingCreateEditResponsibles(
        responsible: ResponsibleDto(name: "José", picture: AppFile.empty()),
        isSaving: false,
      ),
    );
    final widget = TestScaffold(
      child: BlocProvider<CreateEditResponsiblesCubit>(
        create: (_) => cubit,
        child: CreateEditResponsibleBody(),
      ),
    );
    await tester.pumpWidget(widget);

    expect(
      find.byWidgetPredicate(
        (element) => element is TextFormField && element.initialValue == "José",
      ),
      findsOneWidget,
    );
  });

  testWidgets('Deve exibir icone de salvando', (tester) async {
    final state = EditingCreateEditResponsibles(
      responsible: ResponsibleDto(name: "José", picture: AppFile.empty()),
      isSaving: true,
    );
    when(() => cubit.state).thenReturn(state);
    final widget = TestScaffold(
      child: BlocProvider<CreateEditResponsiblesCubit>(
        create: (_) => cubit,
        child: CreateEditResponsibleBody(),
      ),
    );
    await tester.pumpWidget(widget);

    expect(
      find.byType(CircularProgressIndicator),
      findsOneWidget,
    );
  });
}
