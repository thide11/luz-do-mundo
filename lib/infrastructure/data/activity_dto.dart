import 'dart:convert';

import 'package:luz_do_mundo/domain/entity/activity.dart';
import 'package:luz_do_mundo/infrastructure/data/enum_dto.dart';
import 'package:luz_do_mundo/infrastructure/repository/core/firestore_model.dart';

class ActivityDto {
  String id;
  String title;
  String? description;
  ActivityType type;
  double? amountSpend;
  ActivityDto({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    this.amountSpend,
  });

  factory ActivityDto.fromDomain(Activity activity) {
    return ActivityDto(
      id: activity.id, 
      title: activity.title, 
      description: activity.description, 
      type: activity.type,
      amountSpend: activity.amountSpend,
    );
  }

  FirestoreModel toFirestore() {
    return FirestoreModel({
      'title': title,
      'description': description,
      'type': EnumDto.getValue(type),
      'amountSpend': amountSpend,
    }, id );
  }

  ActivityDto copyWith({
    String? id,
    String? title,
    String? description,
    ActivityType? type,
    double? amountSpend,
  }) {
    return ActivityDto(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      amountSpend: amountSpend ?? this.amountSpend,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': EnumDto.getValue(type),
      'amountSpend': amountSpend,
    };
  }

  factory ActivityDto.fromMap(Map<String, dynamic> map) {
    return ActivityDto(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      type: EnumDto.findValue(ActivityType.values, map['type']),
      amountSpend: map['amountSpend'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityDto.fromJson(String source) => ActivityDto.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ActivityDto(id: $id, title: $title, description: $description, type: $type, amountSpend: $amountSpend)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ActivityDto &&
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.type == type &&
      other.amountSpend == amountSpend;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      type.hashCode ^
      amountSpend.hashCode;
  }
}
