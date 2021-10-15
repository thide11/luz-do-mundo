part of 'show_calendar_cubit.dart';

class ShowCalendarState extends Equatable {
  final DateTime showingMonth;
  final DateTime selectedDay;
  final FilterState filters;
  final List<Activity> loadedActivities;

  List<Activity> get showingActionPlans {
    return loadedActivities.where(
      (activity) => 
        activity.type == ActivityType.ACTION_PLAN && 
        selectedDay.isAtSameMomentAs(activity.date!)
    ).toList();
  }

  List<Activity> get showingAccompaiment {
    return loadedActivities.where(
      (activity) => 
        activity.type == ActivityType.ACCOMPANIMENT && 
        selectedDay.isAtSameMomentAs(activity.date!)
    ).toList();
  }

  ShowCalendarState({
    required this.showingMonth,
    required this.selectedDay,
    required this.loadedActivities,
    required this.filters,
  });

  @override
  List<Object> get props => [showingMonth, selectedDay, loadedActivities, filters];

  ShowCalendarState copyWith({
    DateTime? showingMonth,
    DateTime? selectedDay,
    List<Activity>? loadedActivities,
    FilterState? filters,
  }) {
    return ShowCalendarState(
      showingMonth: showingMonth ?? this.showingMonth,
      selectedDay: selectedDay ?? this.selectedDay,
      loadedActivities: loadedActivities ?? this.loadedActivities,
      filters: filters ?? this.filters,
    );
  }
}
