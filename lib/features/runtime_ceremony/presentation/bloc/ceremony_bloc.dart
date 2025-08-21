import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tea_list/core/entities/spill_entity.dart';
import 'package:tea_list/core/models/ceremony_model.dart';
import 'package:tea_list/features/runtime_ceremony/domain/repository/runtime_ceremony_repository.dart';
import 'package:tea_list/features/runtime_ceremony/domain/timer/timer_tea_ceremony.dart';

part 'ceremony_event.dart';
part 'ceremony_state.dart';

class CeremonyBloc extends Bloc<CeremonyEvent, CeremonyState> {
  List<SpillEntity> spills = [];
  RuntimeCeremonyRepository runtimeCeremonyRepository;

  final timer = TimerTeaCeremony();

  String? smellOfDryLeaves, temperature, weightOfTea, other, capacity, material;

  CeremonyBloc({required this.runtimeCeremonyRepository}) : super(CeremonyInitial([])) {
    on<OnWarmedUpCeremonyEvent>(_dishesWasWarmed);
    on<StartSpillTimerEvent>(_startSpillTimer);
    on<StopSpillTimerEvent>(_stopSpillTimer);
    on<TabChangedEvent>(_onTabChanged);
    on<UpdateSpillFieldEvent>(_onFieldUpdated);
    on<SuccessFinishEvent>(_onSuccessFinish);
    on<UpdateCeremonyFieldEvent>(_onUpdateCeremonyField);
  }

  void _onUpdateCeremonyField(UpdateCeremonyFieldEvent event, Emitter<CeremonyState> emit) {
    smellOfDryLeaves = event.smellOfDryLeaves;
    weightOfTea = event.weightOfTea;
    temperature = event.temperature;
    other = event.other;
    capacity = event.capacity;
    material = event.material;
  }

  Future<void> _onSuccessFinish(SuccessFinishEvent event, Emitter<CeremonyState> emit) async {
    final imagePath = event.imagePath;
    final dateString = "${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}";

    final ceremony = CeremonyModel(
      material: material,
      capacity: capacity,
      spills: spills,
      date: dateString,
      imagePath: imagePath,
      smellOfDryLeaves: smellOfDryLeaves,
      temperature: temperature,
      other: other,
      weightOfTea: weightOfTea,
    );

    final result = await runtimeCeremonyRepository.tryFinishCeremony(ceremony);
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
      timeOfSpill: event.timeOfSpill,
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
    emit(StartCeremonyState(spills));
  }

  void _startSpillTimer(StartSpillTimerEvent event, Emitter<CeremonyState> emit) {
    emit(SpillStartState(spills));
  }

  void _stopSpillTimer(StopSpillTimerEvent event, Emitter<CeremonyState> emit) {
    spills.add(SpillEntity(timeOfSpill: event.seconds));
    emit(SpillStopState(spills));
  }
}
