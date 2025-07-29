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
      emit(LoginLoadingState());

      final newUser = UserEntity(name: "name", email: event.email, password: event.password);

      final response = await _authRepository.loginWithEmail(newUser);

      response.fold(
        (fail) {
          emit(LoginErrorState(message: "Проверьте логин или пароль"));
          emit(LoginInitial());
        },
        (success) {
          emit(SuccessLoginState(message: success));
        },
      );
    } on Object catch (error, stack) {
      throw Exception("Error in Login Bloc. Error: $error StackTrace: $stack");
    }
  }
}
