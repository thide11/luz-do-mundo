import 'package:flutter/material.dart';
import 'package:luz_do_mundo/application/core/base_crud_states.dart';

Widget baseCrudWrapper<T extends Object>(BaseCrudStates<T> state, {
  Widget onLoading()?,
  Widget onEmpty()?,
  Widget onError(ErrorBaseCrudStates<T> state)?,
  required Widget onLoaded(T data),
}) {
  if (state is LoadingBaseCrudStates) {
    return onLoading != null ? onLoading() : Center(child: CircularProgressIndicator());
  }
  if (state is EmptyBaseCrudStates) {
    return onEmpty != null ? onEmpty() : Container();
  }
  if (state is ErrorBaseCrudStates) {
    print((state as ErrorBaseCrudStates).message);
    return onError != null ? onError(state as ErrorBaseCrudStates<T>) : Text("Ocorreu um erro :(");
  }
  if (state is LoadedBaseCrudStates) {
    return onLoaded((state as LoadedBaseCrudStates<T>).data);
  }
  return Container();
}