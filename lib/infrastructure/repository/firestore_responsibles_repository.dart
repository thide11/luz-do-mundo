import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/domain/entity/responsible.dart';
import 'package:luz_do_mundo/domain/repository/responsible_repository.dart';
import 'package:luz_do_mundo/infrastructure/data/responsible_serializable.dart';
import 'package:luz_do_mundo/infrastructure/repository/core/firestore_crud.dart';
import 'package:luz_do_mundo/infrastructure/repository/core/firestore_model.dart';
import 'package:luz_do_mundo/infrastructure/repository/firestore_activity_repository.dart';

class FirestoreResponsiblesRepository extends FirestoreCrud<Responsible>
    implements ResponsibleRepository {
  @override
  String basePath = "/responsibles";
  ResponsibleSerializable _serializable = ResponsibleSerializable();
  FirebaseStorage _storage;

  FirestoreResponsiblesRepository(FirebaseFirestore firestore, this._storage)
      : super(firestore);

  @override
  Future<void> disableOrDelete(Responsible responsible) async {
    final id = responsible.id!;
    final data = await firestore.collection(
      FirestoreActivityRepository(firestore).basePath
    ).where(
      "responsible.id",
      isEqualTo: id
    ).get();
    if(data.docs.isEmpty) {
      if(responsible.picture != null && responsible.picture!.isNotEmpty) {
        await _findResponsibleFileById(id).delete();
      }
      return super.delete(id);
    } else {
      return super.edit(
        responsible.copyWith(
          enabled: false
        )
      );
    }
  }

  

  @override
  Responsible readFirestoreDocument(DocumentSnapshot data) {
    return _serializable.fromFirestore(data);
  }

  @override
  Future<void> edit(Responsible data) async {
    if (data.picture?.tempFile != null) {
      await _findResponsibleFileById(data.id!).putFile(data.picture!.tempFile!);
    }
    await super.edit(data);
  }

  @override
  Future<String> create(Responsible data) async {
    final id = new DateTime.now().millisecondsSinceEpoch.toString();
    if (data.picture?.tempFile != null) {
      await _insertPhoto(id, data.picture!.tempFile!);
    }
    await super.create( data.copyWith(id: id) );
    return id;
  }

  @override
  Future<List<Responsible>> list() async {
    final responsibles = await super.list();
    return await Future.wait(responsibles.map(_readResponsibleFile));
  }
  
  @override
  Stream<List<Responsible>> listStream() {
    return super.createStream(
      firestore.collection(basePath).where(
        "enabled",
        isEqualTo: true,
      )
    ).asyncMap((e) async => await Future.wait(e.map(_readResponsibleFile)));
  }

  Future<Responsible> _readResponsibleFile(Responsible responsible) async {
    try {
      final reference = _findResponsibleFileById(responsible.id!);
      final fileUrl = await reference.getDownloadURL();
      final metadata = await reference.getMetadata();
      return responsible.copyWith(
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

  Reference _findResponsableFolderById(String id) {
    return this._storage.ref("/responsibles/$id");
  }

  Reference _findResponsibleFileById(String id) {
    return _findResponsableFolderById(id).child("/responsibles/$id/profile.jpeg");
  }

  Future<void> _insertPhoto(String responsibleId, File file) async {
    await _findResponsibleFileById(responsibleId)
        .putFile(file);
  }

  @override
  FirestoreModel toFirestore(Responsible data) {
    return _serializable.toFirestore(data);
  }
}
