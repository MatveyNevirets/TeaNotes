import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ceremony_event.dart';
part 'ceremony_state.dart';

class CeremonyBloc extends Bloc<CeremonyEvent, CeremonyState> {
  CeremonyBloc() : super(CeremonyInitial()) {
    on<OnClearedTeaCeremonyEvent>(_teaWasCleared);
    on<OnWarmedUpCeremonyEvent>(_dishesWasWarmed);
    on<StartSpillTimerEvent>(_startSpillTimer);
    on<StopSpillTimerEvent>(_stopSpillTimer);
  }
  void _dishesWasWarmed(OnWarmedUpCeremonyEvent event, Emitter<CeremonyState> emit) {
    emit(ClearTeaCeremonyState());
  }

  void _teaWasCleared(OnClearedTeaCeremonyEvent event, Emitter<CeremonyState> emit) {
    emit(StartCeremonyState());
  }

  void _startSpillTimer(StartSpillTimerEvent event, Emitter<CeremonyState> emit) {
    emit(SpillStartState());
  }

  void _stopSpillTimer(StopSpillTimerEvent event, Emitter<CeremonyState> emit) {
    emit(SpillStopState());
  }
}
