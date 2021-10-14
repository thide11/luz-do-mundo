import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/domain/entity/base_person.dart';

class BasePersonSerializable {
  Map<String, dynamic> toMap(BasePerson basePerson) {
    return {
      'id': basePerson.id,
      'name': basePerson.name,
      'picture': basePerson.picture?.toMap(),
    };
  }

  BasePerson fromMap(Map<String, dynamic> map) {
    return BasePerson(
      id: map['id'],
      name: map['name'],
      picture: AppFile.fromMap(map['picture']),
    );
  }
}