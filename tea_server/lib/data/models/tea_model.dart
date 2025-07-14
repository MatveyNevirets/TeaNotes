// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:sqlite3/sqlite3.dart';

class Tea {
  int? id;
  String title;
  String description;
  String imagePath;
  String brewingTemperature;
  String gatheringPlace;
  String type;

  int pricePerGram;
  int age;
  int countOfSpills;
  int gatheringYear;

  Tea({
    this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.pricePerGram,
    required this.age,
    required this.type,
    required this.brewingTemperature,
    required this.countOfSpills,
    required this.gatheringYear,
    required this.gatheringPlace,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'imagePath': imagePath,
      'brewingTemperature': brewingTemperature,
      'gatheringPlace': gatheringPlace,
      'type': type,
      'pricePerGram': pricePerGram,
      'age': age,
      'countOfSpills': countOfSpills,
      'gatheringYear': gatheringYear,
    };
  }

  factory Tea.fromRow(Row row) {
    return Tea(
      id: row['id'] as int,
      title: row['title'] as String,
      description: row['description'] as String,
      imagePath: row['imagePath'] as String,
      pricePerGram: row['pricePerGram'] as int,
      age: row['age'] as int,
      type: row['type'] as String,
      brewingTemperature: row['brewingTemperature'] as String,
      countOfSpills: row['countOfSpills'] as int,
      gatheringYear: row['gatheringYear'] as int,
      gatheringPlace: row['gatheringPlace'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}
