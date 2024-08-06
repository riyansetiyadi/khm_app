import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      await loginUser(emit, event);
    });
  }

  loginUser(Emitter<LoginState> emit, LoginEvent event) async* {
    emit(LoginLoading());
    if (event is LoginSubmitted) {
      yield LoginLoading();
      try {
        // Simulate a login API call
        await Future.delayed(Duration(seconds: 2));

        // Assuming login is successful and we get a token
        String token = 'dummy_token';

        // Save the token using shared_preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);

        yield LoginSuccess();
      } catch (e) {
        yield LoginFailure(e.toString());
      }
    } else if (event is LogoutRequested) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      yield LoginInitial();
    }
  }
}
