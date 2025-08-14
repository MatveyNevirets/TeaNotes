// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tea_list/core/models/spill_model.dart';

class CeremonyModel {
  String? date;
  String? imagePath;
  String? smellOfDryLeaves;
  List<SpillModel> spills;
  CeremonyModel({required this.spills, required this.date, required this.imagePath, required this.smellOfDryLeaves});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'smellOfDryLeaves': smellOfDryLeaves,
      'imagePath': imagePath,
      'spills': spills.map((x) => x.toMap()).toList(),
    };
  }

  factory CeremonyModel.fromMap(Map<String, dynamic> map) {
    return CeremonyModel(
      smellOfDryLeaves: map['smellOfDryLeaves'] != null ? map['smellOfDryLeaves'] as String : null,
      imagePath: map['imagePath'] != null ? map['imagePath'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      spills: List<SpillModel>.from(
        (map['spills'] as List<dynamic>).map<SpillModel>((x) => SpillModel.fromMap(x as Map<String, dynamic>)),
      ),
    );
  }
}
