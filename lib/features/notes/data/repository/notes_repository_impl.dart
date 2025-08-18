import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/core/models/ceremony_model.dart';
import 'package:tea_list/features/notes/data/datasources/remote/notes_remote_datasource.dart';
import 'package:tea_list/features/notes/domain/repository/notes_repository.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesRemoteDatasource notesRemoteDatasource;

  NotesRepositoryImpl({required this.notesRemoteDatasource});

  @override
  Future<Either<Failure, List<CeremonyModel>>> fetchUserCeremonies() async {
    return await notesRemoteDatasource.fetchUsersNotes();
  }
}
