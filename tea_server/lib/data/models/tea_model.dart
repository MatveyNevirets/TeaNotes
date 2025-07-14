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

  factory Tea.fromMap(Map<String, dynamic> map) {
    return Tea(
      title: map['title'],
      description: map['description'],
      imagePath: map['imagePath'] ?? '',
      brewingTemperature: map['brewingTemperature'],
      gatheringPlace: map['gatheringPlace'],
      type: map['type'],
      pricePerGram: map['pricePerGram'],
      age: map['age'],
      countOfSpills: map['countOfSpills'],
      gatheringYear: map['gatheringYear'],
    );
  }

  factory Tea.fromRow(Row row) {
    return Tea(
      id: row['id'] as int,
      title: row['title']?.toString() ?? '',
      description: row['description']?.toString() ?? '',
      imagePath: row['imagePath']?.toString() ?? '',
      pricePerGram: row['pricePerGram'] as int,
      age: row['age'] as int,
      type: row['type']?.toString() ?? '',
      brewingTemperature: row['brewingTemperature']?.toString() ?? '',
      countOfSpills: row['countOfSpills'] as int,
      gatheringYear: row['gatheringYear'] as int,
      gatheringPlace: row['gatheringPlace']?.toString() ?? '',
    );
  }
}
