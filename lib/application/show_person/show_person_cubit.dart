import 'dart:io';
import 'dart:typed_data';

import 'package:luz_do_mundo/application/core/base_crud_cubit.dart';
import 'package:luz_do_mundo/application/core/base_crud_states.dart';
import 'package:luz_do_mundo/domain/entity/base_person.dart';
import 'package:luz_do_mundo/domain/entity/needy_person.dart';
import 'package:luz_do_mundo/domain/repository/person_repository.dart';
import 'package:luz_do_mundo/infrastructure/utils/pdf_builder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShowPersonCubit extends BaseCrudCubit<NeedyPerson> {
  PersonRepository _personRepository;
  late String personId;
  ShowPersonCubit(this._personRepository, BasePerson needyPerson) : super() {
    assert(needyPerson.id != null);
    personId = needyPerson.id!;
    if(needyPerson is NeedyPerson) {
      emit(
        LoadedBaseCrudStates(needyPerson)
      );
    }
  }

  Future<Uint8List> buildPdf() async {
    if(state is LoadedBaseCrudStates<NeedyPerson>) {
      final needyPersonState = state as LoadedBaseCrudStates<NeedyPerson>;
      final uint = await pdfBuilder(
        needyPersonState.data
      );
      return uint;
      
    }
    return Uint8List(0);
  }

  @override
  load() {
    super.loadStreamData(() => _personRepository.show(personId));
  }
}
