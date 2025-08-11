// ignore_for_file: public_member_api_docs, sort_constructors_first
class SpillModel {
  int? spillNumber;
  String? smellUnderLid;
  String? smellFromGaiwan;
  String? smellFromEmptyBowl;
  String? smellFromEmptyChaHai;

  String? colorOfTea;
  String? tasteOfTea;

  String? impressions;
  String? teaState;
  SpillModel({
    this.spillNumber,
    this.smellUnderLid,
    this.smellFromGaiwan,
    this.smellFromEmptyBowl,
    this.smellFromEmptyChaHai,
    this.colorOfTea,
    this.tasteOfTea,
    this.impressions,
    this.teaState,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'spillNumber': spillNumber,
      'smellUnderLid': smellUnderLid,
      'smellFromGaiwan': smellFromGaiwan,
      'smellFromEmptyBowl': smellFromEmptyBowl,
      'colorOfTea': colorOfTea,
      'tasteOfTea': tasteOfTea,
      'impressions': impressions,
      'teaState': teaState,
    };
  }

  factory SpillModel.fromMap(Map<String, dynamic> map) {
    return SpillModel(
      spillNumber: map['spillNumber'] as int,
      smellUnderLid: map['smellUnderLid'] as String,
      smellFromGaiwan: map['smellFromGaiwan'] as String,
      smellFromEmptyBowl: map['smellFromEmptyBowl'] as String,
      colorOfTea: map['colorOfTea'] as String,
      tasteOfTea: map['tasteOfTea'] as String,
      impressions: map['impressions'] as String,
      teaState: map['teaState'] as String,
    );
  }

  SpillModel copyWith({
    int? spillNumber,
    String? smellUnderLid,
    String? smellFromGaiwan,
    String? smellFromEmptyBowl,
    String? smellFromEmptyChaHai,
    String? colorOfTea,
    String? tasteOfTea,
    String? impressions,
    String? teaState,
  }) {
    return SpillModel(
      spillNumber: spillNumber ?? this.spillNumber,
      smellUnderLid: smellUnderLid ?? this.smellUnderLid,
      smellFromGaiwan: smellFromGaiwan ?? this.smellFromGaiwan,
      smellFromEmptyBowl: smellFromEmptyBowl ?? this.smellFromEmptyBowl,
      smellFromEmptyChaHai: smellFromEmptyChaHai ?? this.smellFromEmptyChaHai,
      colorOfTea: colorOfTea ?? this.colorOfTea,
      tasteOfTea: tasteOfTea ?? this.tasteOfTea,
      impressions: impressions ?? this.impressions,
      teaState: teaState ?? this.teaState,
    );
  }
}
