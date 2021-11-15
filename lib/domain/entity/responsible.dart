
import 'app_file.dart';
import 'base_person.dart';

class Responsible extends BasePerson {
  Responsible({
    String? id,
    required String name,
    required String telephone,
    AppFile? picture,
  }) : super(
    id: id,
    name: name,
    picture: picture,
    telephone: telephone,
  );

  factory Responsible.fromBasePerson(BasePerson basePerson) {
    return Responsible(
      id: basePerson.id,
      name: basePerson.name,
      telephone: basePerson.telephone,
      picture: basePerson.picture,
    );
  }

  Responsible copyWith({
    String? id,
    String? name,
    String? telephone,
    AppFile? picture,
  }) {
    return Responsible(
      id: id ?? this.id,
      name: name ?? this.name,
      telephone: telephone ?? this.telephone,
      picture: picture ?? this.picture,
    );
  }
}
