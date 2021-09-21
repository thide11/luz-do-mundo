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

  @override
  List<Object?> get props => [id, name, birthDate, rg, adress, telephone, motherName, fatherName, income, workCard, photo, dependents];
}
