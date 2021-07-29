import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injector/injector.dart';
import 'package:luz_do_mundo/application/create_edit_responsibles_cubit/create_edit_responsibles_cubit.dart';
import 'package:luz_do_mundo/application/list_responsibles_cubit.dart';
import 'package:luz_do_mundo/domain/repository/responsible_repository.dart';
import 'package:luz_do_mundo/infrastructure/repository/firestore_responsibles_repository.dart';

loadDi() {
  final injector = Injector.appInstance;
  injector.registerSingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  injector.registerSingleton<ResponsibleRepository>(() => FirestoreResponsiblesRepository(injector.get<FirebaseFirestore>()));
  injector.registerDependency<ListResponsiblesCubit>(() => ListResponsiblesCubit(injector.get<ResponsibleRepository>()));
  injector.registerSingleton<CreateEditResponsiblesCubit>(() => CreateEditResponsiblesCubit(injector.get<ResponsibleRepository>()));
}