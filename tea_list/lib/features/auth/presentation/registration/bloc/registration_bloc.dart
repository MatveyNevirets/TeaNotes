import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:tea_list/features/auth/domain/entity/user_entity.dart';
import 'package:tea_list/features/auth/domain/repository/auth_repository.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRepository _authRepository;
  FirebaseAuth auth = FirebaseAuth.instance;

  RegistrationBloc(this._authRepository) : super(RegistrationInitial()) {
    on<TryRegisterEvent>(_tryRegister);
  }

  Future<void> _tryRegister(TryRegisterEvent event, Emitter<RegistrationState> emit) async {
    emit(LoadingRegistration());

    final newUser = UserEntity(name: event.name, email: event.email, password: event.password);
    final result = await _authRepository.registerWithEmail(
      user: newUser,
      onSend: () {
        emit(LetterHasBeenSended(message: "Письмо отправлено!\n(Проверьте спам)"));
      },
    );

    result.fold(
      (error) {
        emit(ErrorRegistration(error: error.error, stack: error.stack));
      },
      (success) {
        emit(SuccessRegistration(message: success));
      },
    );
  }
}
