import 'package:equatable/equatable.dart';

import 'dependent.dart';
import 'app_file.dart';

class NeedyPerson extends Equatable {
  String? id;
  String name;
  DateTime birthDate;
  String rg;
  String adress;
  String telephone;
  String motherName;
  String fatherName;
  int income;
  AppFile? workCard;
  AppFile? photo;
  List<Dependent> dependents;

  NeedyPerson({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.rg,
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
