import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/core/models/ceremony_model.dart';

abstract class NotesRemoteDatasource {
  Future<Either<Failure, List<CeremonyModel>>> fetchUsersNotes();
}