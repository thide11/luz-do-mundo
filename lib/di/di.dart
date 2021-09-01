import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injector/injector.dart';
import 'package:luz_do_mundo/application/create_edit_responsibles_cubit/create_edit_responsibles_cubit.dart';
import 'package:luz_do_mundo/application/list_responsibles_cubit.dart';
import 'package:luz_do_mundo/domain/repository/responsible_repository.dart';
import 'package:luz_do_mundo/infrastructure/repository/firestore_responsibles_repository.dart';

loadDi() {
  final injector = Injector.appInstance;
  injector.registerSingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  injector.registerSingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  injector.registerSingleton<ResponsibleRepository>(() => FirestoreResponsiblesRepository(injector.get<FirebaseFirestore>(), injector.get<FirebaseStorage>()));
  injector.registerDependency<ListResponsiblesCubit>(() => ListResponsiblesCubit(injector.get<ResponsibleRepository>()));
  injector.registerDependency<CreateEditResponsiblesCubit>(() => CreateEditResponsiblesCubit(injector.get<ResponsibleRepository>()));
}