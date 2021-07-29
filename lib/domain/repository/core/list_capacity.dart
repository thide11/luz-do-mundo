mixin ListCapacity<T> {
  Future<List<T>> list();
  Stream<List<T>> listStream();
}