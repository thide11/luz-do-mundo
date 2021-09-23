part of 'dependents_manager_cubit.dart';

class DependentsManagerState extends Equatable {
  final int dependentEditingIndex;
  final Dependent? dependentEditingDraft;
  final List<Dependent> dependents;

  DependentsManagerState({
    required this.dependentEditingIndex,
    this.dependentEditingDraft,
    required this.dependents,
  });

  @override
  List<Object?> get props => [dependentEditingIndex, dependentEditingDraft, dependents];

  DependentsManagerState copyWith({
    int? dependentEditingIndex,
    required Dependent? dependentEditingDraft,
    List<Dependent>? dependents,
  }) {
    return DependentsManagerState(
      dependentEditingIndex: dependentEditingIndex ?? this.dependentEditingIndex,
      dependentEditingDraft: dependentEditingDraft,
      dependents: dependents ?? this.dependents,
    );
  }
}

