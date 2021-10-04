import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:luz_do_mundo/domain/entity/activity.dart';
import 'package:luz_do_mundo/domain/repository/activity_repository.dart';

part 'create_edit_action_state.dart';

class CreateEditActionCubit extends Cubit<CreateEditActionState> {

  ActivityRepository _activityRepository;
  CreateEditActionCubit(this._activityRepository, Activity activity) : super(CreateEditActionState(activity: activity));

  onDescriptionChanged(String description) {
    emit(
      state.copyWith(
        activity: state.activity.copyWith(
          description: description,
        )
      )
    );
  }

  onTitleChanged(String title) {
    emit(
      state.copyWith(
        activity: state.activity.copyWith(
          title: title,
        )
      )
    );
  }

  onDateChanged(DateTime date) {
    emit(
      state.copyWith(
        activity: state.activity.copyWith(
          date: date,
        )
      )
    );
  }

  onAmountSpendChanged(String amountSpend) {
    emit(
      state.copyWith(
        activity: state.activity.copyWith(
          amountSpend: double.tryParse(amountSpend)
        )
      )
    );
  }
  
  save() async {
    final activity = state.activity;
    emit(
      state.copyWith(
        isSaving: true,
      )
    );
    if (activity.id == null) {
      await _activityRepository.create(activity);
    } else {
      await _activityRepository.edit(activity);
    }
    emit(
      state.copyWith(
        successfulSaved: true,
      )
    );
    print(state.activity.toString());
  }
}
