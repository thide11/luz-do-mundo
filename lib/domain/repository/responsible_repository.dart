import 'package:luz_do_mundo/domain/entity/responsible.dart';

import 'core/crud_capacity.dart';

abstract class ResponsibleRepository extends CrudCapacity<Responsible> {
  Future<void> disableOrDelete(Responsible responsible);
}