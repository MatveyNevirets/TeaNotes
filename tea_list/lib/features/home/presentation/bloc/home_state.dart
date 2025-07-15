part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

class LoadingState extends HomeState {}

class HasDataState extends HomeState {
  HasDataState(this.teaList);
  List<TeaModel> teaList;
}

class ErrorState extends HomeState {
  ErrorState(this.error);
  String error;
}
