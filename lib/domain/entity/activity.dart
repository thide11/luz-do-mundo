import 'package:equatable/equatable.dart';
import 'package:luz_do_mundo/domain/entity/base_person.dart';
import 'package:luz_do_mundo/utils/datetime_extension.dart';

class Activity extends Equatable {
  final String? id;
  final String title;
  final String? description;
  final ActivityType type;
  final double? amountSpend;
  final DateTime? date;
  final BasePerson? beneficiary;
  final BasePerson? responsible;

  get isEditing => id != null;

  Activity({
    this.id,
    required this.title,
    required this.description,
    required this.type,
    this.date,
    this.amountSpend,
    this.beneficiary,
    this.responsible,
  });

  factory Activity.empty(ActivityType type, DateTime? date) => Activity(
    title: "",
    description: "",
    type: type,
    amountSpend: type == ActivityType.ACCOMPANIMENT ? 0.0 : null,
    date: date ?? DateTimeEx.nowWithoutTime(),
  );

  @override
  List<Object?> get props {
    return [
      id,
      title,
      date,
      description,
      type,
      amountSpend,
      beneficiary,
      responsible
    ];
  }

  Activity copyWith({
    String? id,
    String? title,
    String? description,
    ActivityType? type,
    double? amountSpend,
    DateTime? date,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      amountSpend: amountSpend ?? this.amountSpend,
      date: date ?? this.date,
      beneficiary: this.beneficiary,
      responsible: this.responsible,
    );
  }

  Activity copyWithBasePersons({String? id,
    String? title,
    String? description,
    ActivityType? type,
    double? amountSpend,
    DateTime? date,
    required BasePerson? beneficiary,
    required BasePerson? responsible,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      amountSpend: amountSpend ?? this.amountSpend,
      date: date ?? this.date,
      beneficiary: beneficiary,
      responsible: responsible,
    );
  }
}

enum ActivityType {
  ACTION_PLAN,
  ACCOMPANIMENT,
}
