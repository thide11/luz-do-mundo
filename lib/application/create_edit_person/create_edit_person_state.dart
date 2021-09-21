part of 'create_edit_person_cubit.dart';

abstract class CreateEditPersonState extends Equatable {
  const CreateEditPersonState();

  @override
  List<Object> get props => [];
}

class EmptyCreateEditPerson extends CreateEditPersonState {}

class EditingCreateEditPerson extends CreateEditPersonState {
  final NeedyPersonDto needyPerson;
  final int currentPage;
  final bool isSaving;

  EditingCreateEditPerson({required this.currentPage, required this.needyPerson, required this.isSaving});

  @override
  List<Object> get props => [needyPerson, currentPage];
}

class SucessCreateEditPerson extends CreateEditPersonState {}
