// ignore_for_file: public_member_api_docs, sort_constructors_first

class Tea {
  String title;
  String description;
  String imagePath;

  int pricePerGram;

  int age;
  String type;
  int brewingTemperature;
  int countOfSpills;

  int gatheringYear;
  String gatheringPlace;

  Tea({
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
}
