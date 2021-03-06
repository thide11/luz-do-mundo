import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/domain/entity/dependent.dart';
import 'package:luz_do_mundo/domain/entity/needy_person.dart';
import 'package:luz_do_mundo/infrastructure/data/dependent_serializable.dart';
import 'package:luz_do_mundo/infrastructure/repository/core/firestore_model.dart';

class NeedyPersonSerializable {
  final _dependentSerializable = DependentSerializable();
  Map<String, dynamic> toMap(NeedyPerson needyPerson) {
    return {
      'id': needyPerson.id,
      ...toMapWithoutId(needyPerson),
    };
  }

  Map<String, dynamic> toMapWithoutId(NeedyPerson needyPerson) {
    return {
      'birthDate': Timestamp.fromDate(needyPerson.birthDate),
      'rg': needyPerson.rg,
      'cpf': needyPerson.cpf,
      'adress': needyPerson.adress,
      'motherName': needyPerson.motherName,
      'fatherName': needyPerson.fatherName,
      'income': needyPerson.income,
      'workCard': needyPerson.workCard?.toMap(),
      'dependents': needyPerson.dependents.map((x) => _dependentSerializable.toMap(x)).toList(),
      ...needyPerson.toMapWithoutId(),
    };
  }

  NeedyPerson fromMap(Map<String, dynamic> map) {
    return NeedyPerson(
      name: map['name'],
      birthDate: (map['birthDate'] as Timestamp).toDate(),
      rg: map['rg'],
      cpf: map['cpf'],
      adress: map['adress'],
      telephone: map['telephone'],
      motherName: map['motherName'],
      fatherName: map['fatherName'],
      income: map['income'],
      workCard: AppFile.fromMap(map['workCard']),
      picture: AppFile.fromMap(map['picture'] ?? null),
      dependents: List<Dependent>.from(map['dependents']?.map((x) => _dependentSerializable.fromMap(x))),
    );
  }

  String toJson(NeedyPerson needyPerson) => json.encode(toMap(needyPerson));

  FirestoreModel toFirestore(NeedyPerson needyPerson) => FirestoreModel(
    toMapWithoutId(needyPerson),
    needyPerson.id
  );

  NeedyPerson fromFirestore(DocumentSnapshot document) {
    assert(document.exists);
    return fromMap(Map<String, dynamic>.from(document.data() as dynamic)).copyWith(id: document.id);
  }

  NeedyPerson fromJson(String source) => fromMap(json.decode(source));
}
