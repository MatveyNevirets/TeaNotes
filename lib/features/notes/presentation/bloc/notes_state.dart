// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notes_bloc.dart';

@immutable
sealed class NotesState {}

final class NotesInitial extends NotesState {}

class SuccessFetchedNotesState extends NotesState {
  List<CeremonyModel> ceremonies;
  SuccessFetchedNotesState({required this.ceremonies});
}

class ErrorFetchedNotesState extends NotesState {}
