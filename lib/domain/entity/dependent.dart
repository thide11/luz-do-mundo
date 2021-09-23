
import 'package:equatable/equatable.dart';

class Dependent extends Equatable {
  final String? age;
  final String name;
  final String? rg;
  
  Dependent({
    this.age,
    required this.name,
    this.rg,
  });

  factory Dependent.empty() => Dependent(name: "");
  
  @override
  List<Object?> get props => [age, name, rg];

  Dependent copyWith({
    String? age,
    String? name,
    String? rg,
  }) {
    return Dependent(
      age: age ?? this.age,
      name: name ?? this.name,
      rg: rg ?? this.rg,
    );
  }
}
