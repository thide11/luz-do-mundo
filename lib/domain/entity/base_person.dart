import 'package:equatable/equatable.dart';

import 'app_file.dart';

class BasePerson extends Equatable {
  final String? id;
  final String name;
  final String telephone;
  final AppFile? picture;
  get firstName => name.split(" ")[0];

  BasePerson({
    this.id,
    required this.name,
    required this.telephone,
    this.picture,
  });

  factory BasePerson.empty() => BasePerson(
    id: null,
    name: "",
    telephone: "",
    picture: null,
  );

  @override
  List<Object?> get props => [id, name, telephone, picture];

  BasePerson baseCopyWith({
    String? id,
    String? name,
    String? telephone,
    AppFile? picture,
  }) {
    return BasePerson(
      id: id ?? this.id,
      name: name ?? this.name,
      telephone: telephone ?? this.telephone,
      picture: picture ?? this.picture,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id!,
      "name": name,
      "telephone": telephone,
      "picture": picture?.toMap(),
    };
  }
}