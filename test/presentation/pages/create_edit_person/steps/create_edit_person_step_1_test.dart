import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luz_do_mundo/application/create_edit_person/create_edit_person_cubit.dart';
import 'package:luz_do_mundo/presentation/pages/create_edit_person/steps/create_edit_person_step_1.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/fixtures.dart';
import '../../../../utils/test_scaffold.dart';

class MockCreateEditPersonCubit extends MockCubit<CreateEditPersonState>
    implements CreateEditPersonCubit {}

void main() {
  setUpAll(() {
    registerFallbackValue(EmptyCreateEditPerson());
  });

  testWidgets('create edit person step 1 ...', (tester) async {
    final cubit = MockCreateEditPersonCubit();
    final person = Fixtures.needyPerson();

    whenListen(
      cubit,
      Stream.fromIterable(
        [
          EditingCreateEditPerson(
            needyPerson: person,
            currentPage: 1,
            isSaving: false,
          ),
        ],
      ),
    );

    await tester.pumpWidget(
      TestScaffold(
        child: BlocProvider<CreateEditPersonCubit>(
          create: (context) => cubit,
          child: CreateEditPersonStep1(),
        ),
      ),
    );
    
  });
}
