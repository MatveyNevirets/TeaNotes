import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:tea_list/core/consts/tea_types_list.dart';
import 'package:tea_list/core/models/tea_model.dart';
import 'package:tea_list/features/home/domain/repository/tea_list_repository.dart';

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
      // We create filter string that will be have type of the tea.
      // When index is 0 we'll be show the users all teas we're having.
      // The type is selected from index of our teaTypesList where all the tea types are recorded
      final String? teaFilter = event.teaTypeIndex != 0 ? teaTypesList[event.teaTypeIndex] : null;

      // Here we fetch result from repository on domain layer
      // We called fetchTeaList method and give teaFilter
      // When method was completed this one return
      // Two variations - success with teaList or failure
      final result = await teaListRepository.fetchTeaList(teaFilter);

      // Here we choose state which we'll show to the user
      result.fold(
        (failure) {
          log("Error: ${failure.error} StackTrace: ${failure.stack}");
          emit(ErrorState("Error in fetch data from server. Error: ${failure.error} StackTrace: ${failure.stack}"));
        },
        (teaList) {
          emit(HasDataState(teaList.reversed.toList()));
        },
      );
    } on Object catch (error, stack) {
      throw Exception("Error in home bloc: $error StackTrace: $stack");
    }
  }
}
