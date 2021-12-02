
import 'app_file.dart';
import 'base_person.dart';

class Responsible extends BasePerson {
  Responsible({
    String? id,
    required String name,
    String? telephone,
    AppFile? picture,
    bool enabled = true,
  }) : super(
    id: id,
    name: name,
    picture: picture,
    telephone: telephone,
    enabled: enabled,
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
    bool? enabled,
  }) {
    return Responsible(
      id: id ?? this.id,
      name: name ?? this.name,
      telephone: telephone ?? this.telephone,
      picture: picture ?? this.picture,
      enabled: enabled != null ? enabled : this.enabled,
    );
  }
}
