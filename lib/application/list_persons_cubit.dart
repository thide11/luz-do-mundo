import 'package:luz_do_mundo/application/core/base_crud_cubit.dart';
import 'package:luz_do_mundo/domain/entity/needy_person.dart';
import 'package:luz_do_mundo/domain/repository/person_repository.dart';

class ListPersonsCubit extends BaseCrudCubit<List<NeedyPerson>> {
  PersonRepository _personRepository;
  ListPersonsCubit(this._personRepository);

  load() async {
    await super.loadStreamData(() => _personRepository.listStream());
  }

  onFilterChanged(String filter) async {
    streamSubscription = _personRepository.listStreamFilterByName(filter).listen(
      onDataReceived, 
      onError: onErrorReceived
    );
  }
}