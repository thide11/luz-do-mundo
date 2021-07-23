import 'dependent.dart';
import 'file.dart';

class NeedyPerson {
  String id;
  String name;
  DateTime birthDate;
  String rg;
  String adress;
  String telephone;
  String motherName;
  String fatherName;
  int income;
  File workCard;
  File photo;
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
}
