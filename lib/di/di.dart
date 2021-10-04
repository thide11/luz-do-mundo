import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injector/injector.dart';
import 'package:luz_do_mundo/application/create_edit_person/create_edit_person_cubit.dart';
import 'package:luz_do_mundo/application/create_edit_responsibles_cubit/create_edit_responsibles_cubit.dart';
import 'package:luz_do_mundo/application/list_persons_cubit.dart';
import 'package:luz_do_mundo/application/list_responsibles_cubit.dart';
import 'package:luz_do_mundo/application/show_calendar/show_calendar_cubit.dart';
import 'package:luz_do_mundo/domain/repository/activity_repository.dart';
import 'package:luz_do_mundo/domain/repository/person_repository.dart';
import 'package:luz_do_mundo/domain/repository/responsible_repository.dart';
import 'package:luz_do_mundo/infrastructure/repository/firestore_activity_repository.dart';
import 'package:luz_do_mundo/infrastructure/repository/firestore_person_repository.dart';
import 'package:luz_do_mundo/infrastructure/repository/firestore_responsibles_repository.dart';

loadDi() {
  final injector = Injector.appInstance;
  injector.registerSingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  injector.registerSingleton<FirebaseStorage>(() => FirebaseStorage.instance);

  injector.registerSingleton<ResponsibleRepository>(() => FirestoreResponsiblesRepository(injector.get<FirebaseFirestore>(), injector.get<FirebaseStorage>()));
  injector.registerSingleton<PersonRepository>(() => FirestorePersonRepository(injector.get<FirebaseFirestore>(), injector.get<FirebaseStorage>()));
  injector.registerSingleton<ActivityRepository>(() => FirestoreActivityRepository(injector.get<FirebaseFirestore>()));

  injector.registerDependency<ListResponsiblesCubit>(() => ListResponsiblesCubit(injector.get<ResponsibleRepository>()));
  injector.registerDependency<ListPersonsCubit>(() => ListPersonsCubit(injector.get<PersonRepository>()));
  injector.registerDependency<ShowCalendarCubit>(() => ShowCalendarCubit(injector.get<ActivityRepository>()));
  
  injector.registerDependency<CreateEditResponsiblesCubit>(() => CreateEditResponsiblesCubit(injector.get<ResponsibleRepository>()));
  injector.registerDependency<CreateEditPersonCubit>(() => CreateEditPersonCubit(injector.get<PersonRepository>()));
}