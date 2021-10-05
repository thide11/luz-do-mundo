import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:luz_do_mundo/application/core/base_crud_cubit.dart';
import 'package:luz_do_mundo/application/core/base_crud_states.dart';
import 'package:luz_do_mundo/domain/entity/activity.dart';
import 'package:luz_do_mundo/domain/repository/activity_repository.dart';

part 'show_activity_state.dart';

class ShowActivityCubit extends BaseCrudCubit<Activity> {
  ActivityRepository _activityRepository;
  late String activityId;

  ShowActivityCubit(this._activityRepository, Activity activity) : super(
    LoadedBaseCrudStates(activity)
  ) {
    assert(activity.id != null);
    activityId = activity.id!;
  }

  @override
  load() {
    super.loadStreamData(() => _activityRepository.show(activityId));
  }
}