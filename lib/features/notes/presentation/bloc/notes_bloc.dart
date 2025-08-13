import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:tea_list/core/models/ceremony_model.dart';
import 'package:tea_list/features/auth/data/models/user_model.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  NotesBloc({required this.firestore, required this.firebaseAuth}) : super(NotesInitial()) {
    on<FetchNotesEvent>(_fetchNotes);
  }

  Future<void> _fetchNotes(FetchNotesEvent event, Emitter<NotesState> emit) async {
    final uid = firebaseAuth.currentUser!.uid;
    final docs = await firestore.collection("users").doc(uid).get();

    final user = UserModel.fromMap(docs.data()!);

    final ceremonies = user.ceremonies;

    emit(SuccessFetchedNotesState(ceremonies: ceremonies));
  }
}
