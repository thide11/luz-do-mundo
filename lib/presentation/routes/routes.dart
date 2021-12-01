import 'package:luz_do_mundo/presentation/pages/create_edit_activity/create_edit_activity.dart';
import 'package:luz_do_mundo/presentation/pages/create_edit_person/create_edit_person.dart';
import 'package:luz_do_mundo/presentation/pages/create_edit_responsibles/create_edit_responsibles.dart';
import 'package:luz_do_mundo/presentation/pages/home/home.dart';
import 'package:luz_do_mundo/presentation/pages/list_persons/list_persons.dart';
import 'package:luz_do_mundo/presentation/pages/list_responsibles/list_responsibles.dart';
import 'package:luz_do_mundo/presentation/pages/pdf_preview/pdf_preview.dart';
import 'package:luz_do_mundo/presentation/pages/show_activity/show_activity.dart';
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

  static const String showActivity = "/showActivity";
  static const String createEditActivity = "/createEditActivity";
  
  static const String pdfPreview = "/pdfPreviewActivity";

  static getRoutes() => {
    Routes.home: (context) => const Home(),

    Routes.listResponsibles: (context) => const ListResponsibles(),
    Routes.createEditResponsibles: (context) => const CreateEditResponsibiles(),

    Routes.listPersons: (context) => const ListPersons(),
    Routes.createEditPerson: (context) => const CreateEditPerson(),
    Routes.showPerson: (context) => const ShowPerson(),

    Routes.showCalendar: (context) => const ShowCalendar(),

    Routes.showActivity: (context) => const ShowActivity(),
    Routes.createEditActivity: (context) => const CreateEditActivity(),

    Routes.pdfPreview: (context) => const PdfPreview(),
  };
}