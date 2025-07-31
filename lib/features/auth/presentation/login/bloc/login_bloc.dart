import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tea_list/features/auth/domain/entity/user_entity.dart';
import 'package:tea_list/features/auth/domain/repository/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc(this._authRepository) : super(LoginInitial()) {
    on<TryLoginEvent>(_tryLogin);
  }

  Future<void> _tryLogin(TryLoginEvent event, Emitter<LoginState> emit) async {
    try {
      // Here we shows loading screen
      emit(LoginLoadingState());

      // Create new user entity with our parameters
      final newUser = UserEntity(name: "name", email: event.email, password: event.password, teas: []);

      // From auth repository we calls loginWithEmail method
      final response = await _authRepository.loginWithEmail(newUser);

      response.fold(
        (error) {
          // If error we send snackbar message to user
          emit(LoginErrorState(message: "Проверьте логин или пароль"));
          emit(LoginInitial());
        },
        (success) {
          // If successful login we shows HomeScreen
          emit(SuccessLoginState(message: success));
        },
      );
    } on Object catch (error, stack) {
      throw Exception("Error in Login Bloc. Error: $error StackTrace: $stack");
    }
  }
}
