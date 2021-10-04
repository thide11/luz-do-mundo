part of 'create_edit_action_cubit.dart';

class CreateEditActionState extends Equatable {
  final Activity activity;
  final bool isSaving;
  final bool successfulSaved;
  const CreateEditActionState({required this.activity, this.isSaving = false, this.successfulSaved = false});

  CreateEditActionState copyWith({
    Activity? activity,
    bool? isSaving,
    bool? successfulSaved,
  }) {
    return CreateEditActionState(
      activity:  activity ?? this.activity,
      isSaving: isSaving ?? this.isSaving,
      successfulSaved: successfulSaved ?? this.successfulSaved,
    );
  }

  @override
  List<Object> get props => [this.activity, this.isSaving, this.successfulSaved];
}
