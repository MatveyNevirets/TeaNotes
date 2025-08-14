// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ceremony_bloc.dart';

@immutable
sealed class CeremonyEvent {}

class OnWarmedUpCeremonyEvent extends CeremonyEvent {}

class OnClearedTeaCeremonyEvent extends CeremonyEvent {}

class StartSpillTimerEvent extends CeremonyEvent {}

class StopSpillTimerEvent extends CeremonyEvent {}

class SuccessFinishEvent extends CeremonyEvent {
  String? imagePath;
  String? smellOfDryLeaves;
  SuccessFinishEvent({required this.imagePath, required smellOfDryLeaves});
}

class TabChangedEvent extends CeremonyEvent {
  int index;
  List<SpillEntity>? spills;
  TabChangedEvent({required this.index, this.spills});
}

class UpdateSpillFieldEvent extends CeremonyEvent {
  int index;
  String fieldName;
  String value;
  UpdateSpillFieldEvent({required this.index, required this.fieldName, required this.value});
}
