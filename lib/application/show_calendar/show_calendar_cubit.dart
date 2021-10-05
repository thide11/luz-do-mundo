import 'package:equatable/equatable.dart';
import 'package:luz_do_mundo/application/core/base_crud_cubit.dart';
import 'package:luz_do_mundo/application/core/base_crud_states.dart';
import 'package:luz_do_mundo/domain/entity/activity.dart';
import 'package:luz_do_mundo/domain/repository/activity_repository.dart';
import 'package:luz_do_mundo/utils/datetime_extension.dart';

part 'show_calendar_state.dart';

class ShowCalendarCubit extends BaseCrudCubit<ShowCalendarState> {
  ActivityRepository _activityRepository;
  ShowCalendarCubit(this._activityRepository) : super();

  @override
  load() {
    onMonthChanged(DateTimeEx.nowWithoutTime());
  }

  onMonthChanged(DateTime date) {
    super.loadStreamData(
      () => 
      _activityRepository.listByMonth(date).map((e) {
        if(state is LoadedBaseCrudStates<ShowCalendarState>) {
          final state = this.state as LoadedBaseCrudStates<ShowCalendarState>;
          return state.data.copyWith(
            loadedActivities: e,
            showingMonth: date,
          );
        } else {
          return ShowCalendarState(
            loadedActivities: e,
            selectedDay: DateTimeEx.nowWithoutTime(),
            showingMonth: date,
          );
        }
      })
    );
  }

  onSelectedDayChanged(DateTime day) {
    assert(state is LoadedBaseCrudStates<ShowCalendarState>);
    emit(
      LoadedBaseCrudStates(
        (state as LoadedBaseCrudStates<ShowCalendarState>).data.copyWith(
          selectedDay: day
        )
      )
    );
  }
}
