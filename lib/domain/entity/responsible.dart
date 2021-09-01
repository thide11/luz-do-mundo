import 'package:equatable/equatable.dart';

import 'app_file.dart';

class Responsible extends Equatable {
  final String? id;
  final String name;
  final AppFile? picture;

  Responsible({
    this.id,
    required this.name,
    required this.picture,
  });

  @override
  List<Object?> get props => [id, name, picture];
}
