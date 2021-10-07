part of 'create_edit_action_cubit.dart';

class CreateEditActivityState extends Equatable {
  final Activity activity;
  final bool isSaving;
  final bool successfulSaved;
  const CreateEditActivityState({required this.activity, this.isSaving = false, this.successfulSaved = false});

  CreateEditActivityState copyWith({
    Activity? activity,
    bool? isSaving,
    bool? successfulSaved,
  }) {
    return CreateEditActivityState(
      activity:  activity ?? this.activity,
      isSaving: isSaving ?? this.isSaving,
      successfulSaved: successfulSaved ?? this.successfulSaved,
    );
  }

  @override
  List<Object> get props => [this.activity, this.isSaving, this.successfulSaved];
}
