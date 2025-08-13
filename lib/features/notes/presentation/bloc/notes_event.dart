part of 'notes_bloc.dart';

@immutable
sealed class NotesEvent {}

class FetchNotesEvent extends NotesEvent {}