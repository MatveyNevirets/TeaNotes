// ignore_for_file: public_member_api_docs, sort_constructors_first

class TeaModel {
  String id;
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

  bool isFavorite;

  TeaModel({
    required this.id,
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
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
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
      'isFavorite': isFavorite,
    };
  }

  factory TeaModel.fromMap(Map<String, dynamic> map) {
    return TeaModel(
      id: map['id'] as String,
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
      isFavorite: map['isFavorite'] as bool,
    );
  }
}
