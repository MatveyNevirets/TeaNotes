import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/features/runtime_ceremony/data/models/spill_model.dart';

abstract class RemoteDatasource {
  Future<Either<Failure, String>> tryFinishCeremony(List<SpillModel> spills);
}