import 'package:equatable/equatable.dart';

import 'file.dart';

class Responsible extends Equatable {
  String? id;
  String name;
  File? picture;

  Responsible({
    this.id,
    required this.name,
    required this.picture,
  });

  @override
  List<Object?> get props => [id, name, picture];
}
