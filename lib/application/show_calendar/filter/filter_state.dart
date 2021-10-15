part of 'filter_cubit.dart';

class FilterState extends Equatable {
  final BasePerson? responsible;
  final BasePerson? beneficiary;
  FilterState({
    this.responsible,
    this.beneficiary,
  });

  @override
  List<Object?> get props => [responsible, beneficiary];

  FilterState copyWith({
    BasePerson? responsible,
    BasePerson? beneficiary,
  }) {
    return FilterState(
      responsible: responsible ?? this.responsible,
      beneficiary: beneficiary ?? this.beneficiary,
    );
  }

  removeResponsible() {
    return FilterState(
      responsible: null,
      beneficiary: this.beneficiary,
    );
  }

  removeBeneficiary() {
    return FilterState(
      responsible: this.responsible,
      beneficiary: null,
    );
  }
}
