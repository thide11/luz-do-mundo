import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:luz_do_mundo/domain/entity/responsible.dart';
import 'package:luz_do_mundo/domain/repository/responsible_repository.dart';
import 'package:luz_do_mundo/infrastructure/data/responsible_dto.dart';

part 'create_edit_responsibles_state.dart';

class CreateEditResponsiblesCubit extends Cubit<CreateEditResponsiblesState> {
  ResponsibleDto get _responsible {
    assert(state is EditingCreateEditResponsibles);
    return (state as EditingCreateEditResponsibles).responsible;
  }

  set _responsible(ResponsibleDto responsible) {
    emit(
      EditingCreateEditResponsibles(
        responsible,
        false
      )
    );
  }

  ResponsibleRepository _responsibleRepository;
  CreateEditResponsiblesCubit(this._responsibleRepository) : super(EmptyCreateEditResponsibles());

  load([Responsible? responsible]) {
    _responsible = ResponsibleDto.fromDomain(
      responsible ?? Responsible(name: "", picture: null)
    );
  }

  onNameChanged(String name) {
    _responsible = _responsible.copyWith(name: name);
  }

  save() async {
    emit(
      EditingCreateEditResponsibles(
        _responsible,
        true
      )
    );
    if(_responsible.id == null) {
      await _responsibleRepository.create(_responsible);
    } else {
      await _responsibleRepository.edit(_responsible);
    }
    emit(
      SucessCreateEditResponsibles()
    );
  }
}
