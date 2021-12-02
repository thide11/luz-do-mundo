import 'package:equatable/equatable.dart';

import 'app_file.dart';

class BasePerson extends Equatable {
  final String? id;
  final String name;
  final String? telephone;
  final bool enabled;
  final AppFile? picture;
  get firstName => name.split(" ")[0];

  BasePerson({
    this.id,
    required this.name,
    required this.telephone,
    this.picture,
    required this.enabled,
  });

  factory BasePerson.empty() => BasePerson(
    id: null,
    name: "",
    telephone: null,
    enabled: true,
    picture: null,
  );

  @override
  List<Object?> get props => [id, name, telephone, picture];

  BasePerson baseCopyWith({
    String? id,
    String? name,
    String? telephone,
    AppFile? picture,
    bool? enabled,
  }) {
    return BasePerson(
      id: id ?? this.id,
      name: name ?? this.name,
      telephone: telephone ?? this.telephone,
      picture: picture ?? this.picture,
      enabled: enabled ?? this.enabled,
    );
  }

  Map<String, dynamic> toMapWithoutId() {
    return {
      "name": name,
      "telephone": telephone,
      "picture": picture?.toMap(),
      "enabled": enabled,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      ...toMapWithoutId(),
      "id": id!,
    };
  }
}