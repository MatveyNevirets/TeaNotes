import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:tea_list/core/models/tea_model.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final FirebaseAuth auth;

  DetailsBloc({required this.auth}) : super(DetailsInitial()) {
    on<SendDialogDetailsDeleteEvent>(_showsAreYouSureDialog);
    on<ISureDeleteEvent>(_deleteCurrentTea);
  }
  void _showsAreYouSureDialog(SendDialogDetailsDeleteEvent event, Emitter<DetailsState> emit) {
    emit(AreYouSureDeleteDetailsState());
  }

  Future<void> _deleteCurrentTea(ISureDeleteEvent event, Emitter<DetailsState> emit) async {
    try {
      final uid = auth.currentUser!.uid;
      final instance = FirebaseFirestore.instance;
      final tea = event.tea;

      final userRef = instance.collection("users").doc(uid);

      await userRef.update({
        'teas': FieldValue.arrayRemove([tea.toMap()]),
      });
      emit(SuccessfulDeleteState(message: "Чай ${tea.title} успешно удален!"));
    } on Object catch (error, stack) {
      log("Error into details bloc. Error: $error StackTrace: $stack");
      emit(ErrorDeleteState(message: "Неудалось удалить чай"));
    }
  }
}
