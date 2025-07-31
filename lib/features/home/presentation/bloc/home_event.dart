part of 'home_bloc.dart';

sealed class HomeEvent {
  HomeEvent(this.teaTypeIndex);
  int teaTypeIndex;
}

class FetchDataEvent extends HomeEvent {
  FetchDataEvent(super.teaTypeIndex);
}
