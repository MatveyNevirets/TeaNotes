import 'package:tea_list/features/runtime_ceremony/data/models/spill_model.dart';

class SpillEntity extends SpillModel {
  SpillEntity({
    super.smellUnderLid,
    super.smellFromGaiwan,
    super.smellFromEmptyBowl,
    super.smellFromEmptyChaHai,
    super.colorOfTea,
    super.tasteOfTea,
    super.impressions,
    super.teaState,
  });

  @override
  SpillEntity copyWith({
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
    return SpillEntity(
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
