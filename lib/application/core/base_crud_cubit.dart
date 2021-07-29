import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luz_do_mundo/application/core/base_crud_states.dart';

abstract class BaseCrudCubit<T extends Object> extends Cubit<BaseCrudStates<T>> {
  BaseCrudCubit() : super(EmptyBaseCrudStates());

  StreamSubscription<T>? _stream;

  load();

  loadData(Function transaction) async {
    try {
      final data = await transaction();
      onDataReceived(data);
    } on Exception catch (e) {
      onErrorReceived(e);
    }
  }

  loadStreamData(Stream<T> Function() transaction) async {

    _stream = transaction().listen(
      onDataReceived, 
      onError: onErrorReceived
    );
  }

  onErrorReceived(e) {
    emit(
      ErrorBaseCrudStates(e.toString())
    );
  }

  onDataReceived(T data) async {
    emit(
      LoadedBaseCrudStates<T>(data)
    );
  }

  void dispose() async {
    await _stream?.cancel();
  }
}