import 'package:luz_do_mundo/application/core/base_crud_cubit.dart';
import 'package:luz_do_mundo/domain/entity/responsible.dart';
import 'package:luz_do_mundo/domain/repository/responsible_repository.dart';

class ListResponsiblesCubit extends BaseCrudCubit<List<Responsible>> {
  ResponsibleRepository _responsibleRepository;
  ListResponsiblesCubit(this._responsibleRepository);

  load() async {
    await super.loadStreamData(() => _responsibleRepository.listStream());
  }
}