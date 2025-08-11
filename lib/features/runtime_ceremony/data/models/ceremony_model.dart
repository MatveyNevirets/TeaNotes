// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tea_list/features/runtime_ceremony/data/models/spill_model.dart';

class CeremonyModel {
  List<SpillModel> spills;
  CeremonyModel({required this.spills});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'spills': spills.map((x) => x.toMap()).toList()};
  }

  factory CeremonyModel.fromMap(Map<String, dynamic> map) {
    return CeremonyModel(
      spills: List<SpillModel>.from(
        (map['spills'] as List<dynamic>).map<SpillModel>((x) => SpillModel.fromMap(x as Map<String, dynamic>)),
      ),
    );
  }
}
