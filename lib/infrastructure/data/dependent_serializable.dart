import 'dart:convert';

import 'package:luz_do_mundo/domain/entity/dependent.dart';

class DependentSerializable {
  Map<String, dynamic> toMap(Dependent dependent) {
    return {
      'age': dependent.age,
      'name': dependent.name,
      'rg': dependent.rg,
    };
  }

  Dependent fromMap(Map<String, dynamic> map) {
    return Dependent(
      age: map['age'],
      name: map['name'],
      rg: map['rg'],
    );
  }

  String toJson(Dependent needyPerson) => json.encode(toMap(needyPerson));

  Dependent fromJson(String source) => fromMap(json.decode(source));
}