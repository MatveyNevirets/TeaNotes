import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/core/models/ceremony_model.dart';

abstract class NotesRepository {
  Future<Either<Failure, List<CeremonyModel>>> fetchUserCeremonies();
}