import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tea_list/features/auth/domain/repository/auth_repository.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  final AuthRepository _authRepository;

  WelcomeBloc(this._authRepository) : super(WelcomeInitial()) {
    on<TryGoogleSignInEvent>(_tryGoogleSignIn);
  }

  Future<void> _tryGoogleSignIn(TryGoogleSignInEvent event, Emitter<WelcomeState> emit) async {
    // Shows loading screen
    emit(WelcomeLoading());

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
