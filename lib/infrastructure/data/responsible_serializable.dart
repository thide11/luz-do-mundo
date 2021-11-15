import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/domain/entity/responsible.dart';
import 'package:luz_do_mundo/infrastructure/repository/core/firestore_model.dart';

class ResponsibleSerializable {
  Map<String, dynamic> toMap(Responsible responsible) {
    return {
      'id': responsible.id,
      ...toMapWithoutId(responsible),
    };
  }

  Map<String, dynamic> toMapWithoutId(Responsible responsible) {
    return {
      'name': responsible.name,
      'telephone': responsible.telephone,
      'picture': responsible.picture?.toMap(),
    };
  }

  Responsible fromMap(Map<String, dynamic> map) {
    return Responsible(
      name: map['name'],
      telephone: map['telephone'] ?? "",
      picture: AppFile.fromMap(map['picture'] ?? null),
    );
  }

  String toJson(Responsible needyPerson) => json.encode(toMap(needyPerson));

  FirestoreModel toFirestore(Responsible responsible) => FirestoreModel(
    toMapWithoutId(responsible),
    responsible.id
  );

  Responsible fromFirestore(DocumentSnapshot document) {
    assert(document.exists);
    return fromMap(Map<String, dynamic>.from(document.data() as dynamic)).copyWith(id: document.id);
  }

  Responsible fromJson(String source) => fromMap(json.decode(source));
}
