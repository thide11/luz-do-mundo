import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luz_do_mundo/application/core/base_crud_states.dart';

abstract class BaseCrudCubit<T extends Object> extends Cubit<BaseCrudStates<T>> {
  BaseCrudCubit() : super(EmptyBaseCrudStates());

  StreamSubscription<T>? streamSubscription;

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
    if(streamSubscription == null) {
      emit(LoadingBaseCrudStates());
    } else {
      await streamSubscription?.cancel();
    }
    streamSubscription = transaction().listen(
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

  Future<void> close() async {
    print("Close ativado!");
    await streamSubscription?.cancel();
    super.close();
  }
}