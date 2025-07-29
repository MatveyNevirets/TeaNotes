import 'package:bloc/bloc.dart';
import 'package:tea_list/core/models/tea_model.dart';
import 'package:tea_list/features/home/domain/repository/tea_list_repository.dart';

part 'create_tea_event.dart';
part 'create_tea_state.dart';

class CreateTeaBloc extends Bloc<CreateTeaEvent, CreateTeaState> {
  final TeaListRepository teaListRepository;

  CreateTeaBloc({required this.teaListRepository}) : super(CreateTeaInitial()) {
    on<AddTeaEvent>(_onAddedTea);
  }

  Future<void> _onAddedTea(AddTeaEvent event, Emitter<CreateTeaState> emit) async {
    teaListRepository.insertTea(event.tea);
  }
}
