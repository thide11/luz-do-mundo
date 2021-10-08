
import 'app_file.dart';
import 'base_person.dart';

class Responsible extends BasePerson {
  Responsible({
    String? id,
    required String name,
    AppFile? picture,
  }) : super(
    id: id,
    name: name,
    picture: picture,
  );
}
