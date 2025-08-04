part of 'ceremony_bloc.dart';

@immutable
sealed class CeremonyState {}

final class CeremonyInitial extends CeremonyState {}

class ClearTeaCeremonyState extends CeremonyState {}

class StartCeremonyState extends CeremonyState {}