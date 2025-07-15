import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:tea_list/features/home/domain/repository/tea_list_repository.dart';
import 'package:tea_list/shared/data/models/tea_model.dart';
import 'package:tea_list/shared/domain/enums/tea_types_list.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TeaListRepository teaListRepository;

  HomeBloc({required this.teaListRepository}) : super(HomeInitial()) {
    on<FetchDataEvent>(_fetchTeaList);
  }

  Future<void> _fetchTeaList(HomeEvent event, Emitter<HomeState> emit) async {
    emit(LoadingState());

    try {
      final String? teaFilter = event.teaTypeIndex != 0 ? teaTypesList[event.teaTypeIndex] : null;

      final result = await teaListRepository.fetchTeaList(teaFilter);

      result.fold(
        (failure) {
          emit(ErrorState("Ошибка получения данных с сервера"));
        },
        (teaList) {
          log("In BLOC we have teaList: $teaList and type is ${teaList.runtimeType.toString()}");
          log("tea image path: ${teaList[0].imagePath}");
          emit(HasDataState(teaList));
        },
      );
    } on Object catch (error, stack) {
      throw Exception("Error in home bloc: $error StackTrace: $stack");
    }
  }
}
