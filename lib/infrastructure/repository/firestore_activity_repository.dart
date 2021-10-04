import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luz_do_mundo/domain/entity/activity.dart';
import 'package:luz_do_mundo/domain/repository/activity_repository.dart';
import 'package:luz_do_mundo/infrastructure/data/activity_serializable.dart';
import 'package:luz_do_mundo/infrastructure/repository/core/firestore_crud.dart';
import 'package:luz_do_mundo/infrastructure/repository/core/firestore_model.dart';

class FirestoreActivityRepository extends FirestoreCrud<Activity>
    implements ActivityRepository {
  @override
  String basePath = "activity";

  final _serializabler = ActivitySerializable();
  FirebaseFirestore _firestore;

  FirestoreActivityRepository(this._firestore) : super(_firestore);

  @override
  Activity readFirestoreDocument(data) {
    return _serializabler.fromMap(data.data() as dynamic).copyWith(id: data.id);
  }

  @override
  FirestoreModel toFirestore(Activity data) {
    return _serializabler.toFirestore(data);
  }

  @override
  Stream<List<Activity>> listByMonth(DateTime date) {
    final start = new DateTime(date.year, date.month);
    final end = start.add(Duration(days: 31));
    return 
      this
        ._firestore
        .collection(basePath)
        .orderBy("date")
        .startAt([start])
        .endAt([end])
        .snapshots()
        .map((e) => e.docs.map(readFirestoreDocument).toList());
  }
}
