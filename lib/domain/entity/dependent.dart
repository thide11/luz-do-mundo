import 'package:equatable/equatable.dart';

class Dependent extends Equatable {
  final String? age;
  final String name;
  final String? rg;
  
  Dependent({
    required this.age,
    required this.name,
    required this.rg,
  });

  @override
  List<Object?> get props => [age, name, rg];
}
