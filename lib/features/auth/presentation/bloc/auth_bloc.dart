import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tea_list/features/auth/domain/entity/user_entity.dart';
import 'package:tea_list/features/auth/domain/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(UnauthenticateState()) {
    on<LoginEvent>(_tryLogin);
    on<RegisterEvent>(_tryRegister);
    on<CheckUserLoginEvent>(_checkUser);
    on<GoogleSignInEvent>(_tryGoogleSignIn);
    on<LogoutEvent>(_tryLogout);
  }

  Future<void> _tryLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      log("TRy logout");
      // Shows loading screen
      emit(AuthLoadingState());

      // Try fetch result from repository
      final result = await _authRepository.logout();

      result.fold(
        (fail) {
          // If error report about that
          log("Error at auth BLoC with type: ${fail.runtimeType} Error: ${fail.error} StackTrace: ${fail.stack}");
          emit(AuthErrorState(message: "Что-то пошло не так"));
        },
        (success) {
          // If success just go start screen
          emit(UnauthenticateState());
        },
      );
    } on Object catch (error, stack) {
      log("Error at Auth BLoC at logout method. Error: $error StackTrace: $stack");
      emit(AuthErrorState(message: "Что-то пошло не так"));
    }
  }

  Future<void> _tryLogin(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      // Here we shows loading screen
      emit(AuthLoadingState());
      // Create new user entity with our parameters
      final newUser = UserEntity(name: "name", email: event.email, password: event.password, teas: [], ceremonies: []);

      // From auth repository we calls loginWithEmail method
      final response = await _authRepository.loginWithEmail(newUser);

      response.fold(
        (error) {
          // If error we send snackbar message to user
          emit(AuthErrorState(message: "Проверьте логин или пароль"));
          emit(UnauthenticateState());
        },
        (success) {
          // If successful login we shows HomeScreen
          emit(AuthenticatedState(message: success));
        },
      );
    } on Object catch (error, stack) {
      throw Exception("Error in Login Bloc. Error: $error StackTrace: $stack");
    }
  }

  Future<void> _tryRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    // Here we shows loading screen
    emit(AuthLoadingState());

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
        emit(AuthLetterSendedState(message: "Письмо отправлено!\n(Проверьте спам)"));
      },
    );

    result.fold(
      (fail) {
        // When error we shows error snackbar
        log(
          "Error catched at Auth Bloc from auth repository at registerWithEmail method. Error: ${fail.error} StackTrace: ${fail.stack}",
        );
        emit(AuthErrorState(message: "Ошибка регисрации"));
      },
      (success) async {
        if (success.contains("существует")) {
          // If user has exists we go to Initial screen
          // And shows user our message
          emit(UnauthenticateState(message: success));
        } else {
          // If all success we go HomeScreen
          emit(AuthenticatedState(message: success));
        }
      },
    );
  }

  Future<void> _checkUser(CheckUserLoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState());
      // Here we fetch user
      final result = await _authRepository.fetchCurrentUser();

      result.fold(
        (fail) {
          log(
            "Error at AuthBloc from auth repository. Type: ${fail.runtimeType} Error: ${fail.error} StackTrace: ${fail.stack}",
          );
          emit(AuthErrorState(message: "Что-то пошло не так"));
        },
        (user) {
          log(user.toString());
          // Then if that one not null
          if (user != null) {
            // We login with user's account
            emit(AuthenticatedState());
          } else {
            // Else we shows welcome screen to login
            emit(UnauthenticateState());
          }
        },
      );
    } on Object catch (error, stack) {
      throw Exception("Error at Welcome Bloc checkUser method: $error. StackTrace: $stack");
    }
  }

  Future<void> _tryGoogleSignIn(GoogleSignInEvent event, Emitter<AuthState> emit) async {
    // Shows loading screen
    emit(AuthLoadingState());

    try {
      // Here we from auth repository into
      // Implementation send request
      // To try sign in with google
      final result = await _authRepository.signInWithGoogle();

      result.fold(
        (error) {
          // When we have error
          // We shows snackbar and then
          // Go to Welcome screen
          emit(AuthErrorState(message: "Ошибка входа через Google"));
          emit(UnauthenticateState());
        },
        (success) {
          // When we have successful sign in with google
          // We shows snackbar and go home screen
          emit(AuthenticatedState(message: "Приятных чаепитий!"));
        },
      );
    } on Object catch (error, stack) {
      throw Exception("Error into WelcomeBloc. Error: $error, StackTrace: $stack");
    }
  }
}
