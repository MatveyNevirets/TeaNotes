import 'package:tea_list/core/models/spill_model.dart';

class SpillEntity extends SpillModel {
  SpillEntity({
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
