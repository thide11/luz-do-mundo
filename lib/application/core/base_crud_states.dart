import 'package:equatable/equatable.dart';

class BaseCrudStates<T> extends Equatable {
  const BaseCrudStates();

  @override
  List<Object> get props => [];
}

class LoadingBaseCrudStates<T> extends BaseCrudStates<T> {
  const LoadingBaseCrudStates();
}
class EmptyBaseCrudStates<T> extends BaseCrudStates<T> {
  const EmptyBaseCrudStates();
}
class ErrorBaseCrudStates<T> extends BaseCrudStates<T> {
  final String message;
  const ErrorBaseCrudStates(this.message);
  @override
  List<Object> get props => [message];
}
class LoadedBaseCrudStates<T extends Object> extends BaseCrudStates<T> {
  final T data;
  const LoadedBaseCrudStates(this.data);
  @override
  List<Object> get props => [data];
}