class FirestoreModel<T> {
  final String? id;
  final T model;

  FirestoreModel(this.model, [this.id]);
}