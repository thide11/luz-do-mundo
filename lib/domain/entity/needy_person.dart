import 'package:equatable/equatable.dart';

import 'dependent.dart';
import 'app_file.dart';

class NeedyPerson extends Equatable {
  final String? id;
  final String name;
  final DateTime birthDate;
  final String rg;
  final String cpf;
  final String adress;
  final String telephone;
  final String motherName;
  final String fatherName;
  final int income;
  final AppFile? workCard;
  final AppFile? photo;
  final List<Dependent> dependents;

  NeedyPerson({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.rg,
    required this.cpf,
    required this.adress,
    required this.telephone,
    required this.motherName,
    required this.fatherName,
    required this.income,
    required this.workCard,
    required this.photo,
    required this.dependents,
  });

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
    photo: AppFile.empty(), 
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
      photo: photo ?? this.photo,
      dependents: dependents ?? this.dependents,
    );
  }

  @override
  List<Object?> get props => [id, name, birthDate, rg, adress, telephone, motherName, fatherName, income, workCard, photo, dependents];
}
