import 'dart:convert';

import 'package:luz_do_mundo/domain/entity/file.dart';
import 'package:luz_do_mundo/domain/entity/responsible.dart';
import 'package:luz_do_mundo/infrastructure/repository/core/firestore_model.dart';

class ResponsibleDto extends Responsible {
  ResponsibleDto({
    String? id,
    required String name,
    File? file,
  }) : super(id: id, name: name, picture: file);

  factory ResponsibleDto.fromDomain(Responsible responsible) {
    return ResponsibleDto(
      id: responsible.id, 
      name: responsible.name, 
    );
  }

  FirestoreModel toFirestore() {
    return FirestoreModel({
      'name': name,
    }, id );
  }

  ResponsibleDto copyWith({
    String? id,
    String? name,
  }) {
    return ResponsibleDto(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory ResponsibleDto.fromMap(Map<String, dynamic> map) {
    return ResponsibleDto(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponsibleDto.fromJson(String source) => ResponsibleDto.fromMap(json.decode(source));

  @override
  String toString() => 'ResponsibleDto(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ResponsibleDto &&
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
