import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tea_list/core/models/ceremony_model.dart';
import 'package:tea_list/features/notes/domain/repository/notes_repository.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository notesRepository;

  NotesBloc(this.notesRepository) : super(NotesInitial()) {
    on<FetchNotesEvent>(_fetchNotes);
  }

  Future<void> _fetchNotes(FetchNotesEvent event, Emitter<NotesState> emit) async {
    try {
      final result = await notesRepository.fetchUserCeremonies();

      result.fold(
        (fail) {
          log("Error with type ${fail.runtimeType.toString()} : ${fail.error} StackTrace: ${fail.stack}");
          emit(ErrorFetchedNotesState());
        },
        (success) {
          emit(SuccessFetchedNotesState(ceremonies: success));
        },
      );
    } on Object catch (error, stack) {
      throw Exception("Error into NotesBloc $error StackTrace: $stack");
    }
  }
}
