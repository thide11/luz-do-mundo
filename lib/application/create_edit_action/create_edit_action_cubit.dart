import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:luz_do_mundo/domain/entity/activity.dart';
import 'package:luz_do_mundo/domain/entity/base_person.dart';
import 'package:luz_do_mundo/domain/repository/activity_repository.dart';

part 'create_edit_action_state.dart';

class CreateEditActivityCubit extends Cubit<CreateEditActivityState> {

  ActivityRepository _activityRepository;
  CreateEditActivityCubit(this._activityRepository, Activity activity) : super(CreateEditActivityState(activity: activity));

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
          date: date.toUtc().subtract(Duration(hours: 3)),
        )
      )
    );
  }

  onAmountSpendChanged(double amountSpend) {
    emit(
      state.copyWith(
        activity: state.activity.copyWith(
          amountSpend: amountSpend
        )
      )
    );
  }

  onResponsibleChanged(BasePerson? responsible) {
    emit(
      state.copyWith(
        activity: state.activity.copyWithBasePersons(
          responsible: responsible,
          beneficiary: state.activity.beneficiary
        )
      )
    );
  }

  onBeneficiaryChanged(BasePerson? beneficiary) {
    emit(
      state.copyWith(
        activity: state.activity.copyWithBasePersons(
          responsible: state.activity.responsible,
          beneficiary: beneficiary
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
