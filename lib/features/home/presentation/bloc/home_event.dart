part of 'home_bloc.dart';

sealed class HomeEvent {
  HomeEvent(this.teaTypeIndex, {this.searchByName});
  String? searchByName;
  int teaTypeIndex;
}

class FetchDataEvent extends HomeEvent {
  FetchDataEvent(super.teaTypeIndex, {super.searchByName});
}
