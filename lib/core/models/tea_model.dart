import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class TeaModel {
  String title;
  String description;
  String imagePath;

  int pricePerGram;

  int age;
  String type;
  String brewingTemperature;
  int countOfSpills;

  int gatheringYear;
  String gatheringPlace;

  TeaModel({
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
      'title': title,
      'description': description,
      'imagePath': imagePath,
      'pricePerGram': pricePerGram,
      'age': age,
      'type': type,
      'brewingTemperature': brewingTemperature,
      'countOfSpills': countOfSpills,
      'gatheringYear': gatheringYear,
      'gatheringPlace': gatheringPlace,
    };
  }

  factory TeaModel.fromMap(Map<String, dynamic> map) {
    return TeaModel(
      title: map['title'] as String,
      description: map['description'] as String,
      imagePath: map['imagePath'] as String,
      pricePerGram: map['pricePerGram'] as int,
      age: map['age'] as int,
      type: map['type'] as String,
      brewingTemperature: map['brewingTemperature'] as String,
      countOfSpills: map['countOfSpills'] as int,
      gatheringYear: map['gatheringYear'] as int,
      gatheringPlace: map['gatheringPlace'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeaModel.fromJson(String source) => TeaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
