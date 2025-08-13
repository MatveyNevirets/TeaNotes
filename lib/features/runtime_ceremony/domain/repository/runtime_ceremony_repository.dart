import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/features/runtime_ceremony/domain/entities/spill_entity.dart';

abstract class RuntimeCeremonyRepository {
  Future<Either<Failure, String>> tryFinishCeremony(List<SpillEntity> spills); 
}