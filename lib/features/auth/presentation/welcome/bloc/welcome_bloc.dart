// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:tea_list/features/auth/domain/repository/auth_repository.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  final AuthRepository authRepository;
  final FirebaseAuth firebaseAuth;

  WelcomeBloc({required this.authRepository, required this.firebaseAuth}) : super(WelcomeInitial()) {
    on<TryGoogleSignInEvent>(_tryGoogleSignIn);
    on<CheckUserLoginEvent>(_checkUser);
  }

  Future<void> _checkUser(CheckUserLoginEvent event, Emitter<WelcomeState> emit) async {
    try {
      // Here we fetch user
      final user = firebaseAuth.currentUser;

      // Then if that one not null
      if (user != null) {
        // We login with user's account
        emit(WelcomeSuccessSignInState());
      } else {
        // Else we shows welcome screen to login
        emit(WelcomeInitial());
      }
    } on Object catch (error, stack) {
      throw Exception("Error at Welcome Bloc checkUser method: $error. StackTrace: $stack");
    }
  }

  Future<void> _tryGoogleSignIn(TryGoogleSignInEvent event, Emitter<WelcomeState> emit) async {
    // Shows loading screen
    emit(WelcomeLoading());

    try {
      // Here we from auth repository into
      // Implementation send request
      // To try sign in with google
      final result = await authRepository.signInWithGoogle();

      result.fold(
        (error) {
          // When we have error
          // We shows snackbar and then
          // Go to Welcome screen
          emit(WelcomeErrorState(message: "Ошибка входа через Google"));
          emit(WelcomeInitial());
        },
        (success) {
          // When we have successful sign in with google
          // We shows snackbar and go home screen
          emit(WelcomeSuccessSignInState(message: "Приятных чаепитий!"));
        },
      );
    } on Object catch (error, stack) {
      throw Exception("Error into WelcomeBloc. Error: $error, StackTrace: $stack");
    }
  }
}
