import 'dart:convert';

import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/domain/entity/responsible.dart';
import 'package:luz_do_mundo/infrastructure/repository/core/firestore_model.dart';

class ResponsibleDto extends Responsible {
  ResponsibleDto({
    String? id,
    required String name,
    required String telephone,
    AppFile? picture,
  }) : super(id: id, name: name, picture: picture, telephone: telephone);

  factory ResponsibleDto.fromDomain(Responsible responsible) {
    return ResponsibleDto(
      id: responsible.id, 
      name: responsible.name,
      telephone: responsible.telephone,
      picture: responsible.picture,
    );
  }

  FirestoreModel toFirestore() {
    return FirestoreModel({
      'name': name,
      'telephone': telephone,
      'picture': picture != null ? {
        "md5Hash": picture?.md5Hash
      } : null,
    }, id );
  }

  ResponsibleDto copyWith({
    String? id,
    String? name,
    String? telephone,
    AppFile? picture,
  }) {
    return ResponsibleDto(
      id: id ?? this.id,
      name: name ?? this.name,
      telephone: telephone ?? this.telephone,
      picture: picture ?? this.picture,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    final map = Map<String, dynamic>.from({
      'id': id,
      'name': name,
      'telephone': telephone,
    });
    if(picture != null) {
      map['picture'] = picture!.toMap();
    }
    return map;
  }

  factory ResponsibleDto.fromMap(Map<String, dynamic> map) {
    return ResponsibleDto(
      id: map['id'],
      name: map['name'],
      telephone: map['telephone'] ?? "",
      picture: map["picture"] != null ? AppFile(
        md5Hash: map["picture"]["md5Hash"],
        fileUrl: "",
      ) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponsibleDto.fromJson(String source) => ResponsibleDto.fromMap(json.decode(source));
}
