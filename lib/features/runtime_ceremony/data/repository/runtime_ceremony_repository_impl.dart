import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/features/runtime_ceremony/data/datasources/remote/remote_datasource.dart';
import 'package:tea_list/features/runtime_ceremony/data/models/spill_model.dart';
import 'package:tea_list/features/runtime_ceremony/domain/repository/runtime_ceremony_repository.dart';

class RuntimeCeremonyRepositoryImpl implements RuntimeCeremonyRepository {
  final RemoteDatasource remoteDatasource;
  final bool isConnection;
  RuntimeCeremonyRepositoryImpl({required this.remoteDatasource, required this.isConnection});

  @override
  Future<Either<Failure, String>> tryFinishCeremony(List<SpillModel> spills) async {
    return await remoteDatasource.tryFinishCeremony(spills);
  }
}
