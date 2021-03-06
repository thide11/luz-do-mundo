import 'package:luz_do_mundo/domain/repository/core/create_capacity.dart';
import 'package:luz_do_mundo/domain/repository/core/disable_capacity.dart';
import 'package:luz_do_mundo/domain/repository/core/edit_capacity.dart';
import 'package:luz_do_mundo/domain/repository/core/list_capacity.dart';
import 'package:luz_do_mundo/domain/repository/core/show_capacity.dart';

abstract class CrudCapacity<T> with CreateCapacity<T>, DeleteCapacity, EditCapacity<T>, ListCapacity<T>, ShowCapacity<T> {}