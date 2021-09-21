import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/domain/entity/dependent.dart';
import 'package:luz_do_mundo/domain/entity/needy_person.dart';
import 'package:luz_do_mundo/domain/repository/person_repository.dart';

part 'create_edit_person_state.dart';

class CreateEditPersonCubit extends Cubit<CreateEditPersonState> {
  PersonRepository _personRepository;
  CreateEditPersonCubit(this._personRepository) : super(EmptyCreateEditPerson());

  bool lockScroll = false;

  EditingCreateEditPerson? getEditingStateOrNull() {
    if (state is EditingCreateEditPerson) {
      return state as EditingCreateEditPerson;
    }
    return null;
  }

  set _needyPerson(NeedyPerson needyPerson) {
    final editingState = getEditingStateOrNull();
    if (editingState == null) {
      print("Estado indesejado");
      return;
    }
    emit(editingState.copyWith(
      needyPerson: needyPerson,
    ));
  }

  NeedyPerson get _needyPerson {
    final editingState = getEditingStateOrNull();
    if (editingState == null) {
      throw Exception("Estado indesejado");
    }
    return editingState.needyPerson;
  }

  load([NeedyPerson? needyPerson]) {
    final person = needyPerson ?? NeedyPerson.empty();
    emit(EditingCreateEditPerson(
        isSaving: false, currentPage: 0, needyPerson: person));
  }

  forwardPage() {
    if (state is EditingCreateEditPerson) {
      final currentPage = (state as EditingCreateEditPerson).currentPage;
      if (currentPage < 3) {
        setPage(currentPage + 1);
      } else {
        save();
      }
    }
  }

  setPageAndLock(int page) {
    setPage(page);
    lockScroll = true;
  }

  setPage(int page) {
    if (lockScroll) {
      final editingState = getEditingStateOrNull();
      if (editingState == null) {
        print("OPS!");
        return;
      }
      if (editingState.currentPage == page) {
        lockScroll = false;
      }
      return;
    }
    emit(EditingCreateEditPerson(
        isSaving: false,
        currentPage: page,
        needyPerson: (state as EditingCreateEditPerson).needyPerson));
  }

  save() async {
    final needyPerson = (state as EditingCreateEditPerson).needyPerson;
    emit(EditingCreateEditPerson(
      isSaving: true,
      currentPage: 3,
      needyPerson: needyPerson,
    ));
    if (needyPerson.id == null) {
      await _personRepository.create(needyPerson);
    } else {
      await _personRepository.edit(needyPerson);
    }
    emit(SucessCreateEditPerson());
  }

  onNameChanged(String name) {
    _needyPerson = _needyPerson.copyWith(name: name);
  }

  onBirthDateChanged(DateTime birthDate) {
    _needyPerson = _needyPerson.copyWith(birthDate: birthDate);
  }

  onRgChanged(String rg) {
    _needyPerson = _needyPerson.copyWith(rg: rg);
  }

  onCpfChanged(String cpf) {
    _needyPerson = _needyPerson.copyWith(cpf: cpf);
  }

  onAdressChanged(String adress) {
    _needyPerson = _needyPerson.copyWith(adress: adress);
  }

  onTelephoneChanged(String telephone) {
    _needyPerson = _needyPerson.copyWith(telephone: telephone);
  }

  onMotherNameChanged(String motherName) {
    _needyPerson = _needyPerson.copyWith(motherName: motherName);
  }

  onFatherNameChanged(String fatherName) {
    _needyPerson = _needyPerson.copyWith(fatherName: fatherName);
  }

  onIncomeChanged(int income) {
    _needyPerson = _needyPerson.copyWith(income: income);
  }

  onWorkCardChanged(AppFile workCard) {
    _needyPerson = _needyPerson.copyWith(workCard: workCard);
  }

  onPhotoChanged(AppFile photo) {
    _needyPerson = _needyPerson.copyWith(photo: photo);
  }

  onDependentChanged(int index, Dependent dependent) {
    final newDependentsList = [..._needyPerson.dependents];
    newDependentsList[index] = dependent;
    _needyPerson = _needyPerson.copyWith(dependents: newDependentsList);
  }
}
