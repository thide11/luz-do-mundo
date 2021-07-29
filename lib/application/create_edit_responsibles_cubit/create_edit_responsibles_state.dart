part of 'create_edit_responsibles_cubit.dart';

abstract class CreateEditResponsiblesState extends Equatable {
  const CreateEditResponsiblesState();

  @override
  List<Object> get props => [];
}

class EmptyCreateEditResponsibles extends CreateEditResponsiblesState {}

class EditingCreateEditResponsibles extends CreateEditResponsiblesState {
  final ResponsibleDto responsible;
  final bool isSaving;
  EditingCreateEditResponsibles(this.responsible, this.isSaving);

  @override
  List<Object> get props => [responsible, isSaving];
}

class SucessCreateEditResponsibles extends CreateEditResponsiblesState {}
