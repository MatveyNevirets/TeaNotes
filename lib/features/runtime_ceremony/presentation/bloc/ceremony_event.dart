part of 'ceremony_bloc.dart';

@immutable
sealed class CeremonyEvent {}

class OnWarmedUpCeremonyEvent extends CeremonyEvent {}

class OnClearedTeaCeremonyEvent extends CeremonyEvent {}
