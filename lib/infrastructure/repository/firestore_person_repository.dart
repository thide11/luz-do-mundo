import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/domain/entity/needy_person.dart';
import 'package:luz_do_mundo/domain/repository/person_repository.dart';
import 'package:luz_do_mundo/infrastructure/data/needy_person_serializable.dart';
import 'package:luz_do_mundo/infrastructure/repository/core/firestore_crud.dart';
import 'package:luz_do_mundo/infrastructure/repository/core/firestore_model.dart';

import 'firestore_activity_repository.dart';

class FirestorePersonRepository extends FirestoreCrud<NeedyPerson> implements PersonRepository {
  @override
  String basePath = "needyPerson";
  final _serializabler = NeedyPersonSerializable();
  FirebaseStorage _storage;
  FirebaseFirestore _firestore;

  FirestorePersonRepository(this._firestore, this._storage) : super(_firestore);


  @override
  Future<void> disableOrDelete(NeedyPerson person) async {
    final id = person.id!;
    final data = await firestore.collection(
      FirestoreActivityRepository(firestore).basePath
    ).where(
      "beneficiary.id",
      isEqualTo: id
    ).get();
    if(data.docs.isEmpty) {
      if(person.picture != null && person.picture!.isNotEmpty) {
        await _findPersonPhotoPathById(id).delete();
      }
      if(person.workCard != null && person.workCard!.isNotEmpty) {
        await _findPersonWorkCardPathById(id).delete();
      }
      return super.delete(id);
    } else {
      return super.edit(
        person.copyWith(
          enabled: false
        )
      );
    }
  }

  @override
  NeedyPerson readFirestoreDocument(DocumentSnapshot<Object?> data) {
    return _serializabler.fromMap(data.data() as dynamic).copyWith(id: data.id);
  }

  Future<NeedyPerson> _readPersonFiles(NeedyPerson responsible) async {
    final photoData = await loadAppFileUrl(
      responsible.picture?.md5Hash, 
      _findPersonPhotoPathById(responsible.id!),
    );
    final workCardData = await loadAppFileUrl(
      responsible.workCard?.md5Hash, 
      _findPersonWorkCardPathById(responsible.id!),
    );

    return responsible.copyWith(
      picture: photoData,
      workCard: workCardData,
    );
  }

  Future<AppFile> loadAppFileUrl(String? md5Hash, Reference reference) async {
    try {
      final fileUrl = await reference.getDownloadURL();
      final metadata = await reference.getMetadata();
      return AppFile(
        md5Hash: md5Hash ?? metadata.md5Hash!,
        fileUrl: fileUrl,
      );
    } on FirebaseException catch (e) {
      if (e.code == "object-not-found") {
        return AppFile.empty();
      } else {
        throw e;
      }
    }
  }

  @override
  Future<String> create(NeedyPerson data) async {
    final id = new DateTime.now().millisecondsSinceEpoch.toString();
    if (data.picture?.tempFile != null) {
      await _insertProfilePhoto(id, data.picture!.tempFile!);
    }
    if(data.workCard?.tempFile != null) {
      await _insertWorkCardPhoto(id, data.workCard!.tempFile!);
    }
    await super.create(data.copyWith(id: id));
    return id;
  }

  @override
  Future<String> edit(NeedyPerson data) async {
    if (data.picture?.tempFile != null) {
      await _insertProfilePhoto(data.id!, data.picture!.tempFile!);
    }
    if(data.workCard?.tempFile != null) {
      await _insertWorkCardPhoto(data.id!, data.workCard!.tempFile!);
    }
    await super.edit(data);
    return data.id!;
  }

  @override
  Future<List<NeedyPerson>> list() async {
    final persons = await super.list();
    return await Future.wait(persons.map(_readPersonFiles));
  }
  
  @override
  Stream<List<NeedyPerson>> listStream() {
    return _attachLoadingOfAppFiles(
      super.createStream(
        firestore.collection(basePath).where(
          "enabled",
          isEqualTo: true,
        )
      )
    );
  }

  @override
  Stream<List<NeedyPerson>> listStreamFilterByName(String name) {
    if(name.isEmpty) {
      return listStream();
    }
    final stream = this._firestore.collection(basePath)
      .orderBy('name')
      .startAt([name])
      .endAt([name + '\uf8ff'])
      .snapshots()
      .map(
        (snapshot) => snapshot.docs.map(readFirestoreDocument).toList()
      );
    return _attachLoadingOfAppFiles(stream);
  }

  Stream<List<NeedyPerson>> _attachLoadingOfAppFiles(Stream<List<NeedyPerson>> stream) {
    return stream.asyncMap((e) async => await Future.wait(e.map(_readPersonFiles)));
  }
  

  Future<void> _insertProfilePhoto(String personId, File file) async {
    await _findPersonPhotoPathById(personId)
        .putFile(file);
  }

  Future<void> _insertWorkCardPhoto(String personId, File file) async {
    await _findPersonWorkCardPathById(personId)
        .putFile(file);
  }

  Reference _findPersonPhotoPathById(String personId) {
    return _storage.ref("/responsibles/$personId/profile.jpeg");
  }
  Reference _findPersonWorkCardPathById(String personId) {
    return _storage.ref("/responsibles/$personId/workCard.jpeg");
  }

  @override
  FirestoreModel toFirestore(NeedyPerson data) => _serializabler.toFirestore(data);

  @override
  Stream<NeedyPerson> show(String id) {
    return super.show(id).asyncMap(_readPersonFiles);
  }
}