import 'package:equatable/equatable.dart';

import 'app_file.dart';

class BasePerson extends Equatable {
  final String? id;
  final String name;
  final AppFile? picture;

  BasePerson({
    this.id,
    required this.name,
    this.picture,
  });

  @override
  List<Object?> get props => [id, name, picture];

  BasePerson copyWith({
    String? id,
    String? name,
    AppFile? picture,
  }) {
    return BasePerson(
      id: id ?? this.id,
      name: name ?? this.name,
      picture: picture ?? this.picture,
    );
  }

  @override
  bool get stringify => true;
}