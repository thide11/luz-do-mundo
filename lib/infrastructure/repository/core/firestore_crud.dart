import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luz_do_mundo/domain/repository/core/crud_capacity.dart';
import 'package:luz_do_mundo/infrastructure/repository/core/firestore_model.dart';

abstract class FirestoreCrud<T> extends CrudCapacity<T> {

  FirebaseFirestore _firestore;

  FirestoreCrud(this._firestore);

  abstract String basePath;
  
  T readFirestoreDocument(DocumentSnapshot data);
  FirestoreModel toFirestore(T data);

  @override
  Future<String> create(T data) async {
    try {
      final firestoreData = toFirestore(data);
      if(firestoreData.id == null) {
        final addData = await _firestore.collection(basePath).add(firestoreData.model);
        return addData.id;
      } else {
        await _firestore.collection(basePath).doc(firestoreData.id).set(firestoreData.model);
        return firestoreData.id!;
      }
    } catch(e) {
      print("Criar");
      print(e);
      return "";
    }
  }

  @override
  Future<void> disable(String id) {
    // TODO: implement disable
    throw UnimplementedError();
  }

  @override
  Future<void> edit(data) async {
    try {
      final firestoreData = toFirestore(data);
      assert(firestoreData.id != null);
      await _firestore.collection(basePath).doc(firestoreData.id).set(firestoreData.model);
    } catch(e) {
      print("Erro ao editar");
      print(e);
    }
  }

  @override
  Future<List<T>> list() async {
    try {
      final data = await _firestore.collection(basePath).get();
      return data.docs.map(readFirestoreDocument).toList();
    } catch(e) {
      print("Criar");
      print(e);
      throw e;
    }
  }

  Stream<List<T>> listStream() {
    return _firestore.collection(basePath).snapshots().map((snapshot) => snapshot.docs.map(readFirestoreDocument).toList());
  }

}