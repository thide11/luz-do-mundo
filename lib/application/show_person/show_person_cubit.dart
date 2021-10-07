import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:luz_do_mundo/application/core/base_crud_cubit.dart';
import 'package:luz_do_mundo/application/core/base_crud_states.dart';
import 'package:luz_do_mundo/domain/entity/activity.dart';
import 'package:luz_do_mundo/domain/entity/needy_person.dart';
import 'package:luz_do_mundo/domain/repository/person_repository.dart';

part 'show_person_state.dart';

class ShowPersonCubit extends BaseCrudCubit<NeedyPerson> {
  PersonRepository _personRepository;
  late String personId;
  ShowPersonCubit(this._personRepository, NeedyPerson needyPerson) : super(
    LoadedBaseCrudStates(needyPerson)
  ) {
    assert(needyPerson.id != null);
    personId = needyPerson.id!;
  }

  @override
  load() {
    super.loadStreamData(() => _personRepository.show(personId));
  }
}
