import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/domain/entity/base_person.dart';
import 'package:luz_do_mundo/domain/entity/responsible.dart';
import 'package:luz_do_mundo/domain/repository/responsible_repository.dart';

part 'create_edit_responsibles_state.dart';

class CreateEditResponsiblesCubit extends Cubit<CreateEditResponsiblesState> {
  Responsible get _responsible {
    assert(state is EditingCreateEditResponsibles);
    return (state as EditingCreateEditResponsibles).responsible;
  }

  set _responsible(Responsible responsible) {
    emit(EditingCreateEditResponsibles(
        responsible: responsible, isSaving: false));
  }

  ResponsibleRepository _responsibleRepository;
  CreateEditResponsiblesCubit(this._responsibleRepository)
      : super(EmptyCreateEditResponsibles());

  load([BasePerson? responsible]) {
    _responsible =
        Responsible.fromBasePerson(responsible ?? BasePerson.empty());
  }

  onNameChanged(String name) {
    _responsible = _responsible.copyWith(name: name);
  }

  onTelephoneChanged(String telphone) {
    _responsible = _responsible.copyWith(telephone: telphone);
  }

  onPictureChanged(AppFile file) {
    _responsible = _responsible.copyWith(picture: file);
  }

  save() async {
    emit(EditingCreateEditResponsibles(
        responsible: _responsible, isSaving: true));
    if (_responsible.id == null) {
      await _responsibleRepository.create(_responsible);
    } else {
      await _responsibleRepository.edit(_responsible);
    }
    emit(SucessCreateEditResponsibles());
  }
}
