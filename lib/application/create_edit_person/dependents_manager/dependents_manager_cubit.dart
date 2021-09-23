import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:luz_do_mundo/domain/entity/dependent.dart';

import '../create_edit_person_cubit.dart';

part 'dependents_manager_state.dart';

class DependentsManagerCubit extends Cubit<DependentsManagerState> {

  final CreateEditPersonCubit _createEditPersonCubit;

  DependentsManagerCubit(this._createEditPersonCubit, {required List<Dependent> dependents}) : super(DependentsManagerState(
    dependentEditingIndex: -1,
    dependents: dependents,
  ));

  onAdd() {
    final newDependentsList = [...state.dependents];
    newDependentsList.add(Dependent.empty());
    emit(
      state.copyWith(
        dependentEditingIndex: newDependentsList.length - 1,
        dependentEditingDraft: Dependent.empty(),
        dependents: newDependentsList,
      )
    );
  }

  onCancelEditing() {
    final newDependentsList = [...state.dependents];
    if(newDependentsList.last.name == "") {
      newDependentsList.removeAt(newDependentsList.length-1);
    }
    emit(
      state.copyWith(
        dependentEditingIndex: -1,
        dependentEditingDraft: null,
        dependents: newDependentsList
      )
    );
  }

  onSave() {
    final newDependentsList = [...state.dependents];
    if(state.dependentEditingDraft!.name == "") {
      newDependentsList.removeAt(state.dependentEditingIndex);
    } else {
      newDependentsList[state.dependentEditingIndex] = state.dependentEditingDraft!;
    }
    emit(
      state.copyWith(
        dependentEditingIndex: -1,
        dependentEditingDraft: null,
        dependents: newDependentsList,
      )
    );
    _createEditPersonCubit.refreshDependentsList(newDependentsList);
  }

  onStartEdit(int index) {
    emit(
      state.copyWith(
        dependentEditingIndex: index,
        dependentEditingDraft: state.dependents[index],
      )
    );
  }

  onDelete(int index) {
    final newDependentsList = [...state.dependents];
    newDependentsList.removeAt(index);
    emit(
      state.copyWith(
        dependentEditingIndex: -1,
        dependentEditingDraft: null,
        dependents: newDependentsList,
      )
    );
  }

  onNameChanged(String name) {
    emit(
      state.copyWith(
        dependentEditingDraft: state.dependentEditingDraft!.copyWith(name: name)
      )
    );
  }

  onAgeChanged(String age) {
    emit(
      state.copyWith(
        dependentEditingDraft: state.dependentEditingDraft!.copyWith(age: age)
      )
    );
  }

  onRgChanged(String rg) {
    emit(
      state.copyWith(
        dependentEditingDraft: state.dependentEditingDraft!.copyWith(rg: rg)
      )
    );
  }
}
