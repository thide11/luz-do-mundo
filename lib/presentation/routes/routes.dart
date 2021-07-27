
import 'package:luz_do_mundo/presentation/pages/create_edit_accompaniment/create_edit_accompaniment.dart';
import 'package:luz_do_mundo/presentation/pages/create_edit_action_plan/create_edit_action_plan.dart';
import 'package:luz_do_mundo/presentation/pages/create_edit_person/create_edit_person.dart';
import 'package:luz_do_mundo/presentation/pages/create_edit_responsibles/create_edit_responsibles.dart';
import 'package:luz_do_mundo/presentation/pages/home/home.dart';
import 'package:luz_do_mundo/presentation/pages/list_persons/list_persons.dart';
import 'package:luz_do_mundo/presentation/pages/list_responsibles/list_responsibles.dart';
import 'package:luz_do_mundo/presentation/pages/show_accompaniment/show_accompaniment.dart';
import 'package:luz_do_mundo/presentation/pages/show_action_plan/show_action_plan.dart';
import 'package:luz_do_mundo/presentation/pages/show_calendar/show_calendar.dart';
import 'package:luz_do_mundo/presentation/pages/show_person/show_person.dart';

abstract class Routes {
  static const String home = "/home";

  static const String listResponsibles = "/listResponsibles";
  static const String createEditResponsibles = "/createEditResponsibles";

  static const String listPersons = "/listPersons";
  static const String createEditPerson = "/createEditPerson";
  static const String showPerson = "/showPerson";

  static const String showCalendar = "/showCalendar";

  static const String showAccompaniment = "/showAccompaniment";
  static const String createEditAccompaniment = "/createEditAccompaniment";
  
  static const String showActionPlan = "/showActionPlan";
  static const String createEditActionPlan = "/createEditActionPlan";

  static getRoutes() => {
    Routes.home: (context) => const Home(),

    Routes.listResponsibles: (context) => const ListResponsibles(),
    Routes.createEditResponsibles: (context) => const CreateEditResponsibiles(),

    Routes.listPersons: (context) => const ListPersons(),
    Routes.createEditPerson: (context) => const CreateEditPerson(),
    Routes.showPerson: (context) => const ShowPerson(),

    Routes.showCalendar: (context) => const ShowCalendar(),

    Routes.showAccompaniment: (context) => const ShowAccompaniment(),
    Routes.createEditAccompaniment: (context) => const CreateEditAccompaniment(),

    Routes.showActionPlan: (context) => const ShowActionPlan(),
    Routes.createEditActionPlan: (context) => const CreateEditActionPlan()
  };
}