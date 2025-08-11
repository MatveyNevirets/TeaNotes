import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tea_list/features/auth/data/models/user_model.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({super.key});

  final instance = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future<int> getCountsOfCeremonies() async {
    final docs = await instance.collection("users").doc(auth.currentUser!.uid).get();

    final user = UserModel.fromMap(docs.data()!);

    log(user.ceremonies.length.toString());
    return user.ceremonies.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getCountsOfCeremonies(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return GridView.builder(
                itemCount: snapshots.data,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Container(margin: EdgeInsets.all(8), height: 50, width: 50, color: Colors.red);
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
