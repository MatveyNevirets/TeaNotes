// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ceremony_bloc.dart';

@immutable
sealed class CeremonyEvent {}

class OnWarmedUpCeremonyEvent extends CeremonyEvent {}

class OnClearedTeaCeremonyEvent extends CeremonyEvent {}

class StartSpillTimerEvent extends CeremonyEvent {}

class StopSpillTimerEvent extends CeremonyEvent {
  int seconds;
  StopSpillTimerEvent({required this.seconds});
}

class SuccessFinishEvent extends CeremonyEvent {
  String? imagePath;
  SuccessFinishEvent({required this.imagePath});
}

class TabChangedEvent extends CeremonyEvent {
  int index;
  List<SpillEntity>? spills;
  TabChangedEvent({required this.index, this.spills});
}

class UpdateCeremonyFieldEvent extends CeremonyEvent {
  String? smellOfDryLeaves, temperature, weightOfTea, other, capacity, material;
  UpdateCeremonyFieldEvent({
    required this.material,
    required this.capacity,
    required this.smellOfDryLeaves,
    required this.other,
    required this.temperature,
    required this.weightOfTea,
  });
}

class UpdateSpillFieldEvent extends CeremonyEvent {
  int index;
  int timeOfSpill;
  String fieldName;
  String value;
  UpdateSpillFieldEvent({required this.index, required this.timeOfSpill, required this.fieldName, required this.value});
}
