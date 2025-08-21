// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tea_list/core/models/spill_model.dart';

class CeremonyModel {
  String? date;
  String? imagePath;
  String? smellOfDryLeaves, temperature, weightOfTea, other;
  List<SpillModel> spills;
  CeremonyModel({
    required this.spills,
    required this.date,
    required this.imagePath,
    required this.smellOfDryLeaves,
    required this.temperature,
    required this.weightOfTea,
    required this.other,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'other': other,
      'smellOfDryLeaves': smellOfDryLeaves,
      'temperature': temperature,
      'weightOfTea': weightOfTea,
      'imagePath': imagePath,
      'spills': spills.map((x) => x.toMap()).toList(),
    };
  }

  factory CeremonyModel.fromMap(Map<String, dynamic> map) {
    return CeremonyModel(
      other: map['other'] != null ? map['other'] as String : null,
      temperature: map['temperature'] != null ? map['temperature'] as String : null,
      weightOfTea: map['weightOfTea'] != null ? map['weightOfTea'] as String : null,
      smellOfDryLeaves: map['smellOfDryLeaves'] != null ? map['smellOfDryLeaves'] as String : null,
      imagePath: map['imagePath'] != null ? map['imagePath'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      spills: List<SpillModel>.from(
        (map['spills'] as List<dynamic>).map<SpillModel>((x) => SpillModel.fromMap(x as Map<String, dynamic>)),
      ),
    );
  }
}
