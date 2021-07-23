import 'package:luz_do_mundo/domain/entity/activity.dart';
import 'package:luz_do_mundo/domain/repository/core/crud_capacity.dart';

abstract class ActivityRepository extends CrudCapacity<Activity> {
  Future<List<Activity>> listByDate(DateTime date);
}