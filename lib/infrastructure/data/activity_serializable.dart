import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luz_do_mundo/domain/entity/activity.dart';
import 'package:luz_do_mundo/infrastructure/data/enum_dto.dart';
import 'package:luz_do_mundo/infrastructure/repository/core/firestore_model.dart';

class ActivitySerializable {
  Map<String, dynamic> toMap(Activity activity) {
    return {
      'id': activity.id,
      ...toMapWithoutId(activity)
    };
  }

  FirestoreModel toFirestore(Activity activity) => FirestoreModel(
    toMapWithoutId(activity),
    activity.id
  );

  Map<String, dynamic> toMapWithoutId(Activity activity) {
    return {
      'title': activity.title,
      'description': activity.description,
      'type': EnumDto.getValue(activity.type),
      'date': Timestamp.fromDate(activity.date!),
      'amountSpend': activity.amountSpend,
    };
  }

  Activity fromMap(Map<String, dynamic> map) {
    return Activity(
      title: map['title'], 
      description: map['description'], 
      type: EnumDto.findValue(ActivityType.values, map['type']),
      date: (map["date"] as Timestamp).toDate(),
      amountSpend: map['amountSpend'],
    );
  }

  String toJson(Activity activity) => json.encode(toMap(activity));

  Activity fromJson(String source) => fromMap(json.decode(source));
}
