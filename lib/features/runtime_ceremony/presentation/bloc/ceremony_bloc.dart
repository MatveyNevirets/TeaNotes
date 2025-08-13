import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tea_list/features/runtime_ceremony/domain/entities/spill_entity.dart';
import 'package:tea_list/features/runtime_ceremony/domain/repository/runtime_ceremony_repository.dart';

part 'ceremony_event.dart';
part 'ceremony_state.dart';

class CeremonyBloc extends Bloc<CeremonyEvent, CeremonyState> {
  List<SpillEntity> spills = [];
  RuntimeCeremonyRepository runtimeCeremonyRepository;

  CeremonyBloc({required this.runtimeCeremonyRepository}) : super(CeremonyInitial([])) {
    on<OnClearedTeaCeremonyEvent>(_teaWasCleared);
    on<OnWarmedUpCeremonyEvent>(_dishesWasWarmed);
    on<StartSpillTimerEvent>(_startSpillTimer);
    on<StopSpillTimerEvent>(_stopSpillTimer);
    on<TabChangedEvent>(_onTabChanged);
    on<UpdateSpillFieldEvent>(_onFieldUpdated);
    on<SuccessFinishEvent>(_onSuccessFinish);
  }

  Future<void> _onSuccessFinish(SuccessFinishEvent event, Emitter<CeremonyState> emit) async {
    final result = await runtimeCeremonyRepository.tryFinishCeremony(spills);
    result.fold(
      (fail) {
        //    emit();
      },
      (success) {
        emit(SuccessFinishState(spills));
      },
    );
  }

  void _onFieldUpdated(UpdateSpillFieldEvent event, Emitter<CeremonyState> emit) {
    final updatedSpills = List<SpillEntity>.from(spills);

    final current = updatedSpills[event.index];

    updatedSpills[event.index] = updatedSpills[event.index].copyWith(
      numberOfSpill: event.index,
      smellUnderLid: event.fieldName == 'smellUnderLid' ? event.value : current.smellUnderLid,
      smellFromGaiwan: event.fieldName == 'smellFromGaiwan' ? event.value : current.smellFromGaiwan,
      smellFromEmptyBowl: event.fieldName == 'smellFromEmptyBowl' ? event.value : current.smellFromEmptyBowl,
      smellFromEmptyChaHai: event.fieldName == 'smellFromEmptyChaHai' ? event.value : current.smellFromEmptyChaHai,
      colorOfTea: event.fieldName == 'colorOfTea' ? event.value : current.colorOfTea,
      tasteOfTea: event.fieldName == 'tasteOfTea' ? event.value : current.tasteOfTea,
      impressions: event.fieldName == 'impressions' ? event.value : current.impressions,
      teaState: event.fieldName == 'teaState' ? event.value : current.teaState,
    );

    spills = updatedSpills;
    emit(ChangedSpillState(event.index, spills));
  }

  void _onTabChanged(TabChangedEvent event, Emitter<CeremonyState> emit) {
    emit(ChangedSpillState(event.index, spills));
  }

  void _dishesWasWarmed(OnWarmedUpCeremonyEvent event, Emitter<CeremonyState> emit) {
    emit(ClearTeaCeremonyState(spills));
  }

  void _teaWasCleared(OnClearedTeaCeremonyEvent event, Emitter<CeremonyState> emit) {
    emit(StartCeremonyState(spills));
  }

  void _startSpillTimer(StartSpillTimerEvent event, Emitter<CeremonyState> emit) {
    emit(SpillStartState(spills));
  }

  void _stopSpillTimer(StopSpillTimerEvent event, Emitter<CeremonyState> emit) {
    spills.add(SpillEntity());
    emit(SpillStopState(spills));
  }
}
