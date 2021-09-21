import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/domain/entity/responsible.dart';
import 'package:luz_do_mundo/domain/repository/responsible_repository.dart';
import 'package:luz_do_mundo/infrastructure/data/responsible_dto.dart';
import 'package:luz_do_mundo/infrastructure/repository/core/firestore_crud.dart';
import 'package:luz_do_mundo/infrastructure/repository/core/firestore_model.dart';

class FirestoreResponsiblesRepository extends FirestoreCrud<Responsible>
    implements ResponsibleRepository {
  @override
  String basePath = "/responsibles";
  FirebaseStorage _storage;

  FirestoreResponsiblesRepository(FirebaseFirestore firestore, this._storage)
      : super(firestore);

  @override
  Responsible readFirestoreDocument(DocumentSnapshot data) {
    return ResponsibleDto.fromMap(data.data() as dynamic).copyWith(id: data.id);
  }

  @override
  Future<void> edit(Responsible data) async {
    await super.edit(data);
    if (data.picture?.tempFile != null) {
      await _findResponsibleFileById(data.id!).putFile(data.picture!.tempFile!);
    }
  }

  @override
  Future<String> create(Responsible data) async {
    final id = new DateTime.now().millisecondsSinceEpoch.toString();
    if (data.picture?.tempFile != null) {
      await _insertPhoto(id, data.picture!.tempFile!);
    }
    await super.create(ResponsibleDto.fromDomain(data).copyWith(id: id));
    return id;
  }

  @override
  Future<List<Responsible>> list() async {
    final responsibles = await super.list();
    return await Future.wait(responsibles.map(_readResponsibleFile));
  }
  
  @override
  Stream<List<Responsible>> listStream() {
    return super.listStream().asyncMap((e) async => await Future.wait(e.map(_readResponsibleFile)));
  }

  Future<Responsible> _readResponsibleFile(Responsible responsible) async {
    try {
      final reference = _findResponsibleFileById(responsible.id!);
      final fileUrl = await reference.getDownloadURL();
      final metadata = await reference.getMetadata();
      return ResponsibleDto.fromDomain(responsible).copyWith(
        picture: AppFile(
          md5Hash: responsible.picture?.md5Hash ?? metadata.md5Hash!,
          fileUrl: fileUrl,
        ),
      );
    } on FirebaseException catch (e) {
      if (e.code == "object-not-found") {
        return responsible;
      } else {
        throw e;
      }
    }
  }

  Reference _findResponsibleFileById(String id) {
    return this._storage.ref("/responsibles/$id/profile.jpeg");
  }

  Future<void> _insertPhoto(String responsibleId, File file) async {
    await _findResponsibleFileById(responsibleId)
        .putFile(file);
  }

  @override
  FirestoreModel toFirestore(Responsible data) {
    return ResponsibleDto.fromDomain(data).toFirestore();
  }
}
