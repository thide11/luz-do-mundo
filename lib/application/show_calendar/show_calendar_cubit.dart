import 'package:equatable/equatable.dart';
import 'package:luz_do_mundo/application/core/base_crud_cubit.dart';
import 'package:luz_do_mundo/application/core/base_crud_states.dart';
import 'package:luz_do_mundo/domain/entity/activity.dart';
import 'package:luz_do_mundo/domain/entity/base_person.dart';
import 'package:luz_do_mundo/domain/repository/activity_repository.dart';
import 'package:luz_do_mundo/utils/datetime_extension.dart';

import 'filter/filter_cubit.dart';

part 'show_calendar_state.dart';

class ShowCalendarCubit extends BaseCrudCubit<ShowCalendarState> {
  ActivityRepository _activityRepository;
  ShowCalendarCubit(this._activityRepository) : super();

  @override
  load() {
    fetchData();
  }

  loadWithFilter(FilterState? filters) {
    fetchData(filters);
  }

  onFilterChanged(FilterState filters) {
    if(state is LoadedBaseCrudStates<ShowCalendarState>) {
      final state = this.state as LoadedBaseCrudStates<ShowCalendarState>;
      emit(
        state.copyWith(
          data: state.data.copyWith(
            filters: filters
          )
        )
      );
      fetchData();
    }
  }

  onMonthChanged(DateTime date) {
    if(state is LoadedBaseCrudStates<ShowCalendarState>) {
      final state = this.state as LoadedBaseCrudStates<ShowCalendarState>;
      emit(
        state.copyWith(
          data: state.data.copyWith(
            showingMonth: date,
          )
        )
      );
      fetchData();
    }
  }

  fetchData([FilterState? filters]) {
    super.loadStreamData(
      () {
      BasePerson? beneficiaryFilter;
      BasePerson? responsibleFilter;
      DateTime date = DateTimeEx.nowWithoutTime();
      if(filters != null) {
        beneficiaryFilter = filters.beneficiary;
        responsibleFilter = filters.responsible; 
      }
      if(state is LoadedBaseCrudStates<ShowCalendarState>) {
        final state = this.state as LoadedBaseCrudStates<ShowCalendarState>;
        beneficiaryFilter = state.data.filters.beneficiary;
        responsibleFilter = state.data.filters.responsible;
        date = state.data.showingMonth;
      }
      return _activityRepository.listByMonthOrResponsibleOrBeneficiary(date, beneficiaryFilter, responsibleFilter,).map((e) {
        if(state is LoadedBaseCrudStates<ShowCalendarState>) {
          final state = this.state as LoadedBaseCrudStates<ShowCalendarState>;
          return state.data.copyWith(
            loadedActivities: e,
          );
        } else {
          return ShowCalendarState(
            loadedActivities: e,
            selectedDay: DateTimeEx.nowWithoutTime(),
            showingMonth: date,
            filters: filters ?? FilterState(),
          );
        }
      });
      }
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
