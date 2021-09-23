import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/domain/entity/needy_person.dart';
import 'package:luz_do_mundo/domain/entity/responsible.dart';

class Fixtures {
  static NeedyPerson needyPerson() {
    return NeedyPerson(
      id: "fakeId",
      name: "Jorge smith", 
      birthDate: DateTime(2000, 9, 30), 
      rg: "3453434", 
      cpf: "236.266.457-63", 
      adress: "Casemiro dias, 32", 
      telephone: "(18) 92394-1924", 
      motherName: "Samira gomes", 
      fatherName: "Jackson alencar", 
      income: 200, 
      workCard: AppFile.empty(), 
      photo: AppFile(fileUrl: "https://example.com", md5Hash: "235"), 
      dependents: []
    );
  }

  static Responsible responsible() {
    return Responsible(
      name: "Rogérin",
      picture: AppFile(fileUrl: "https://fotolegal.com", md5Hash: 'gwegw'),
    );
  }
}