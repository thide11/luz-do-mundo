import 'dart:convert';

import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/domain/entity/responsible.dart';
import 'package:luz_do_mundo/infrastructure/repository/core/firestore_model.dart';

class ResponsibleDto extends Responsible {
  ResponsibleDto({
    String? id,
    required String name,
    AppFile? picture,
  }) : super(id: id, name: name, picture: picture);

  factory ResponsibleDto.fromDomain(Responsible responsible) {
    return ResponsibleDto(
      id: responsible.id, 
      name: responsible.name,
      picture: responsible.picture,
    );
  }

  FirestoreModel toFirestore() {
    return FirestoreModel({
      'name': name,
      'picture': picture != null ? {
        "md5Hash": picture?.md5Hash
      } : null,
    }, id );
  }

  ResponsibleDto copyWith({
    String? id,
    String? name,
    AppFile? picture,
  }) {
    return ResponsibleDto(
      id: id ?? this.id,
      name: name ?? this.name,
      picture: picture ?? this.picture,
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
      picture: map["picture"] != null ? AppFile(
        md5Hash: map["picture"]["md5Hash"],
        filename: "",
        fileUrl: "",
      ) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponsibleDto.fromJson(String source) => ResponsibleDto.fromMap(json.decode(source));
}
