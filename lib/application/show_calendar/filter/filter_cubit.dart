import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:luz_do_mundo/domain/entity/base_person.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit(FilterState baseFilters) : super(baseFilters);

  setBeneficiary(BasePerson beneficiary) {
    emit(
      state.copyWith(
        beneficiary: beneficiary
      )
    );
  }

  setResponsible(BasePerson responsible) {
    emit(
      state.copyWith(
        responsible: responsible
      )
    );
  }

  removeBeneficiary() {
    emit(
      state.removeBeneficiary()
    );
  }

  removeResponsible() {
    emit(
      state.removeResponsible()
    );
  }

  clearFilters() {
    emit(
      FilterState()
    );
  }

}
