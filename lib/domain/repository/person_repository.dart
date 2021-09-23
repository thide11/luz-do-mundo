import 'package:luz_do_mundo/domain/entity/needy_person.dart';

import 'core/crud_capacity.dart';

abstract class PersonRepository extends CrudCapacity<NeedyPerson> {
  Stream<List<NeedyPerson>> listStreamFilterByName(String name);
}