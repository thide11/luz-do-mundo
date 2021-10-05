import 'package:luz_do_mundo/domain/entity/activity.dart';
import 'package:luz_do_mundo/domain/repository/core/crud_capacity.dart';
import 'core/show_capacity.dart';

abstract class ActivityRepository extends CrudCapacity<Activity> with ShowCapacity<Activity> {
  Stream<List<Activity>> listByMonth(DateTime date);

}