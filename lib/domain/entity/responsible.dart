import 'package:equatable/equatable.dart';

import 'app_file.dart';

class Responsible extends Equatable {
  final String? id;
  final String name;
  final AppFile? picture;

  Responsible({
    this.id,
    required this.name,
    this.picture,
  });

  @override
  List<Object?> get props => [id, name, picture];

  Responsible copyWith({
    String? id,
    String? name,
    AppFile? picture,
  }) {
    return Responsible(
      id: id ?? this.id,
      name: name ?? this.name,
      picture: picture ?? this.picture,
    );
  }

  @override
  bool get stringify => true;
}
