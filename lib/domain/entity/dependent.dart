import 'package:equatable/equatable.dart';

class Dependent extends Equatable {
  final String? id;
  final String nome;
  final String? rg;
  
  Dependent({
    required this.id,
    required this.nome,
    required this.rg,
  });

  @override
  List<Object?> get props => [id, nome, rg];
}
