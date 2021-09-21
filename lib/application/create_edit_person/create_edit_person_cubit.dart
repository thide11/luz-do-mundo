import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:luz_do_mundo/domain/entity/needy_person.dart';
import 'package:luz_do_mundo/infrastructure/data/needy_person_dto.dart';

part 'create_edit_person_state.dart';

class CreateEditPersonCubit extends Cubit<CreateEditPersonState> {
  CreateEditPersonCubit() : super(EmptyCreateEditPerson());

  bool lockScroll = false;

  EditingCreateEditPerson? getEditingStateOrNull() {
    if(state is EditingCreateEditPerson) {
      return state as EditingCreateEditPerson;
    }
    return null;
  }

  load([NeedyPerson? needyPerson]) {
    final person = NeedyPersonDto.empty();
    // NeedyPersonDto.fromDomain(
    //   responsible ?? Responsible(name: "", picture: null)
    // );
    emit(
      EditingCreateEditPerson(
        isSaving: false, 
        currentPage: 0, 
        needyPerson: person
      )
    );
  }

  forwardPage() {
    if(state is EditingCreateEditPerson) {
      final currentPage = (state as EditingCreateEditPerson).currentPage;
      if(currentPage < 3) {
        setPage(currentPage + 1);
      } else {
        save();
      }
    }
  }

  setPageAndLock(int page){
    setPage(page);
    lockScroll = true;
  }

  setPage(int page) {
    if(lockScroll) {
      final editingState = getEditingStateOrNull();
      if(editingState == null){
        print("OPS!");
        return;
      }
      if(editingState.currentPage == page) {
        lockScroll = false;
      }
      return;
    }
    emit(
      EditingCreateEditPerson(
        isSaving: false, 
        currentPage: page, 
        needyPerson: (state as EditingCreateEditPerson).needyPerson
      )
    );
  }

  save() async {
    final needyPerson = (state as EditingCreateEditPerson).needyPerson;
    emit(
      EditingCreateEditPerson(
        isSaving: true,
        currentPage: 3,
        needyPerson: needyPerson,
      )
    );
    if(needyPerson.id == null) {
      // await _responsibleRepository.create(_responsible);
    } else {
      // await _responsibleRepository.edit(_responsible);
    }
    emit(
      SucessCreateEditPerson()
    );
  }

}
