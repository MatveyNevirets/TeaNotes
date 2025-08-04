import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ceremony_event.dart';
part 'ceremony_state.dart';

class CeremonyBloc extends Bloc<CeremonyEvent, CeremonyState> {
  CeremonyBloc() : super(CeremonyInitial()) {
    on<OnClearedTeaCeremonyEvent>(_teaWasCleared);
    on<OnWarmedUpCeremonyEvent>(_dishesWasWarmed);
  }
  void _dishesWasWarmed(OnWarmedUpCeremonyEvent event, Emitter<CeremonyState> emit) {
    emit(ClearTeaCeremonyState());
  }

  void _teaWasCleared(OnClearedTeaCeremonyEvent event, Emitter<CeremonyState> emit) {
    emit(StartCeremonyState());
  }
}
