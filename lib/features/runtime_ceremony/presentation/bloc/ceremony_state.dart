// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ceremony_bloc.dart';

@immutable
sealed class CeremonyState {
  final List<SpillEntity> spills;

  const CeremonyState(this.spills);
}

final class CeremonyInitial extends CeremonyState {
  const CeremonyInitial(super.spills);
}

class StartCeremonyState extends CeremonyState {
  const StartCeremonyState(super.spills);
}

class SuccessFinishState extends CeremonyState {
  const SuccessFinishState(super.spills);
}

class ChangedSpillState extends CeremonyState {
  int index;
  ChangedSpillState(this.index, super.spills);
}

class SpillStartState extends CeremonyState {
  const SpillStartState(super.spills);
}

class SpillStopState extends CeremonyState {
  const SpillStopState(super.spills);
}

class ErrorFinishState extends CeremonyState {
  const ErrorFinishState(super.spills);
}
