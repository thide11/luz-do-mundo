import 'package:equatable/equatable.dart';

class Dependent extends Equatable {
  String? id;
  String nome;
  String? rg;
  
  Dependent({
    required this.id,
    required this.nome,
    required this.rg,
  });

  @override
  List<Object?> get props => [id, nome, rg];
}
