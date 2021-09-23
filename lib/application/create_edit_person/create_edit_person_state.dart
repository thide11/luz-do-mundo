part of 'create_edit_person_cubit.dart';

abstract class CreateEditPersonState extends Equatable {
  const CreateEditPersonState();

  @override
  List<Object> get props => [];
}

class EmptyCreateEditPerson extends CreateEditPersonState {}

class EditingCreateEditPerson extends CreateEditPersonState {
  final NeedyPerson needyPerson;
  final int currentPage;
  final bool isSaving;

  EditingCreateEditPerson({
    required this.needyPerson,
    required this.currentPage,
    required this.isSaving,
  });

  @override
  List<Object> get props => [needyPerson, currentPage, isSaving];

  EditingCreateEditPerson copyWith({
    NeedyPerson? needyPerson,
    int? currentPage,
    bool? isSaving,
  }) {
    return EditingCreateEditPerson(
      needyPerson: needyPerson ?? this.needyPerson,
      currentPage: currentPage ?? this.currentPage,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

class SucessCreateEditPerson extends CreateEditPersonState {}
