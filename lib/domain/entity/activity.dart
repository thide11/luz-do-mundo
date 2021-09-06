import 'package:equatable/equatable.dart';

class Activity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final ActivityType type;
  final int? amountSpend;
  
  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    this.amountSpend,
  });

  @override
  List<Object?> get props => [id, title, description, type, amountSpend];
}

enum ActivityType {
  ACTION_PLAN,
  HISTORIC,
}