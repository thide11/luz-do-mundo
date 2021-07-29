import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luz_do_mundo/domain/entity/responsible.dart';
import 'package:luz_do_mundo/domain/repository/responsible_repository.dart';
import 'package:luz_do_mundo/infrastructure/data/responsible_dto.dart';
import 'package:luz_do_mundo/infrastructure/repository/core/firestore_crud.dart';
import 'package:luz_do_mundo/infrastructure/repository/core/firestore_model.dart';

class FirestoreResponsiblesRepository extends FirestoreCrud<Responsible> implements ResponsibleRepository {
  @override
  String basePath = "/responsibles";

  FirestoreResponsiblesRepository(FirebaseFirestore firestore) : super(firestore);

  @override
  Responsible readFirestoreDocument(DocumentSnapshot data) {
    return ResponsibleDto.fromMap(data.data() as dynamic).copyWith(id: data.id);
  }

  @override
  FirestoreModel toFirestore(Responsible data) {
    return ResponsibleDto.fromDomain(data).toFirestore();
  }
}