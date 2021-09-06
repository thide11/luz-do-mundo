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

  bool get isEditing => responsible.id != null;
  
  EditingCreateEditResponsibles({required this.responsible, required this.isSaving});

  @override
  List<Object> get props => [responsible, isSaving];
}

class SucessCreateEditResponsibles extends CreateEditResponsiblesState {}
