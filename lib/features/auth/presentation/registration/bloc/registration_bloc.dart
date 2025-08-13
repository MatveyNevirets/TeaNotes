import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:tea_list/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:tea_list/features/auth/domain/entity/user_entity.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRemoteDataSource _authRepository;
  FirebaseAuth auth = FirebaseAuth.instance;

  RegistrationBloc(this._authRepository) : super(RegistrationInitial()) {
    on<TryRegisterEvent>(_tryRegister);
  }

  Future<void> _tryRegister(TryRegisterEvent event, Emitter<RegistrationState> emit) async {
    // Here we shows loading screen
    emit(LoadingRegistration());

    // Create new User entity with our parameters
    final newUser = UserEntity(
      name: event.name,
      email: event.email,
      password: event.password,
      teas: [],
      ceremonies: [],
    );

    // Here we with our auth repository send request
    // To register new user
    final result = await _authRepository.registerWithEmail(
      user: newUser,
      onSend: () {
        // This is VoidCallback. If we calls this from our implementation
        // We shows to user snackbar with message
        emit(LetterHasBeenSended(message: "Письмо отправлено!\n(Проверьте спам)"));
      },
    );

    result.fold(
      (error) {
        // When error we shows error snackbar
        emit(ErrorRegistration(error: error.error, stack: error.stack));
      },
      (success) async {
        if (success.contains("существует")) {
          // If user has exists we go to Initial screen
          // And shows user our message
          emit(RegistrationInitial(message: success));
        } else {
          // If all success we go HomeScreen
          emit(SuccessRegistration(message: success));
        }
      },
    );
  }
}
