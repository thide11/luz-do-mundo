import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/domain/entity/dependent.dart';
import 'package:luz_do_mundo/domain/entity/needy_person.dart';

class NeedyPersonDto extends NeedyPerson {
  NeedyPersonDto({
    required String? id,
    required String name,
    required DateTime birthDate,
    required String cpf,
    required String rg,
    required String adress,
    required String telephone,
    required String motherName,
    required String fatherName,
    required int income,
    required AppFile? workCard,
    required AppFile? photo,
    required List<Dependent> dependents,
  }) : super(
    id: id,
    name: name,
    birthDate: birthDate,
    cpf: cpf,
    rg: rg,
    adress: adress,
    telephone: telephone,
    motherName: motherName,
    fatherName: fatherName,
    income: income,
    workCard: workCard,
    photo: photo,
    dependents: dependents,
  );

  factory NeedyPersonDto.empty() => NeedyPersonDto(
    id: "", 
    name: "", 
    birthDate: DateTime.now(), 
    rg: "", 
    cpf: "",
    adress: "", 
    telephone: "", 
    motherName: "", 
    fatherName: "", 
    income: 0, 
    workCard: AppFile.empty(), 
    photo: AppFile.empty(), 
    dependents: []
  );

}