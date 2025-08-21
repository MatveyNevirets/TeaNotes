import 'package:tea_list/core/models/spill_model.dart';

class SpillEntity extends SpillModel {
  SpillEntity({
    required super.timeOfSpill,
    super.numberOfSpill,
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
    int? numberOfSpill,
    int? timeOfSpill,
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
      timeOfSpill: timeOfSpill ?? this.timeOfSpill,
      numberOfSpill: numberOfSpill ?? this.numberOfSpill,
      smellUnderLid: smellUnderLid ?? smellUnderLid,
      smellFromGaiwan: smellFromGaiwan ?? smellFromGaiwan,
      smellFromEmptyBowl: smellFromEmptyBowl ?? smellFromEmptyBowl,
      smellFromEmptyChaHai: smellFromEmptyChaHai ?? smellFromEmptyChaHai,
      colorOfTea: colorOfTea ?? colorOfTea,
      tasteOfTea: tasteOfTea ?? tasteOfTea,
      impressions: impressions ?? impressions,
      teaState: teaState ?? teaState,
    );
  }
}
