import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tea_list/core/models/ceremony_model.dart';
import 'package:tea_list/features/auth/data/models/user_model.dart';
import 'package:tea_list/features/notes/widgets/note_widget.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({super.key});

  final instance = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future<List<CeremonyModel>> getCountsOfCeremonies() async {
    final docs = await instance.collection("users").doc(auth.currentUser!.uid).get();

    final user = UserModel.fromMap(docs.data()!);

    log(user.ceremonies.length.toString());
    return user.ceremonies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Center(
          child: FutureBuilder(
            future: getCountsOfCeremonies(),
            builder: (context, snapshots) {
              if (snapshots.hasData) {
                return GridView.builder(
                  itemCount: snapshots.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return NoteWidget(ceremony: snapshots.data![index], index: index);
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
