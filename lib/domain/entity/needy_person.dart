import 'package:luz_do_mundo/domain/entity/base_person.dart';

import 'app_file.dart';
import 'dependent.dart';

class NeedyPerson extends BasePerson {
  final DateTime birthDate;
  final String rg;
  final String cpf;
  final String adress;
  final String telephone;
  final String motherName;
  final String fatherName;
  final int income;
  final AppFile? workCard;
  final List<Dependent> dependents;

  NeedyPerson({
    String? id,
    required String name,
    required this.birthDate,
    required this.rg,
    required this.cpf,
    required this.adress,
    required this.telephone,
    required this.motherName,
    required this.fatherName,
    required this.income,
    required this.workCard,
    AppFile? picture,
    required this.dependents,
  }) : super(
    name: name,
    id: id,
    picture: picture,
  );

  factory NeedyPerson.empty() => NeedyPerson(
    id: null,
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
    picture: AppFile.empty(), 
    dependents: [],
  );

  NeedyPerson copyWith({
    String? id,
    String? name,
    DateTime? birthDate,
    String? rg,
    String? cpf,
    String? adress,
    String? telephone,
    String? motherName,
    String? fatherName,
    int? income,
    AppFile? workCard,
    AppFile? photo,
    List<Dependent>? dependents,
  }) {
    return NeedyPerson(
      id: id ?? this.id,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      rg: rg ?? this.rg,
      cpf: cpf ?? this.cpf,
      adress: adress ?? this.adress,
      telephone: telephone ?? this.telephone,
      motherName: motherName ?? this.motherName,
      fatherName: fatherName ?? this.fatherName,
      income: income ?? this.income,
      workCard: workCard ?? this.workCard,
      picture: picture ?? this.picture,
      dependents: dependents ?? this.dependents,
    );
  }

  @override
  List<Object?> get props => [id, name, birthDate, rg, cpf, adress, telephone, motherName, fatherName, income, workCard, picture, dependents];
}
