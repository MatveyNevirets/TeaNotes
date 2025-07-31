part of 'details_bloc.dart';

@immutable
sealed class DetailsEvent {}

class SendDialogDetailsDeleteEvent extends DetailsEvent {}

class ISureDeleteEvent extends DetailsEvent {
  final TeaModel tea;

  ISureDeleteEvent({required this.tea});
}
