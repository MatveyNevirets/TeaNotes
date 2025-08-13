import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tea_list/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:tea_list/features/notes/presentation/notes_screen.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.I;

    return BlocProvider(
      create:
          (context) =>
              NotesBloc(firestore: getIt<FirebaseFirestore>(), firebaseAuth: getIt<FirebaseAuth>())
                ..add(FetchNotesEvent()),
      child: NotesScreen(),
    );
  }
}
