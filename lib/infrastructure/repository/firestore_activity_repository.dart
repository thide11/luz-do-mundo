import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luz_do_mundo/domain/entity/activity.dart';
import 'package:luz_do_mundo/infrastructure/data/activity_dto.dart';
import 'package:luz_do_mundo/infrastructure/repository/core/firestore_crud.dart';
import 'package:luz_do_mundo/infrastructure/repository/core/firestore_model.dart';

class FirestoreActivityRepository extends FirestoreCrud<Activity> {

  @override
  String basePath = "activity";

  FirestoreActivityRepository(FirebaseFirestore firestore) : super(firestore);

  @override
  Activity readFirestoreDocument(data) {
    // return ActivityRepository.fromMap(data.data() as dynamic).copyWith(id: data.id);
    throw UnimplementedError();
  }

  @override
  FirestoreModel toFirestore(Activity data) {
    return ActivityDto.fromDomain(data).toFirestore();
  }
}