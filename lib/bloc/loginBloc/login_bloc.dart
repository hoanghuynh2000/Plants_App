import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/bloc/loginBloc/login_event.dart';
import 'package:plants_app/bloc/loginBloc/login_state.dart';
import 'package:plants_app/respository/user_respon.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserResponsitory? userResponsitory;
  LoginBloc({this.userResponsitory}) : super(LoginInitialState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonOnPressEvent) {
      yield LoginLoadingState();
      try {
        var user =
            await userResponsitory!.SignInUser(event.email!, event.password!);
        yield LoginSucessfulState(user!);
      } catch (e) {
        var errorMessage = 'Tài khoản không tồn  tại';
        switch (e) {
          case "firebase_auth/user-not-found":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "ERROR_WRONG_PASSWORD":
            errorMessage = "Your password is wrong.";
            break;
          case "ERROR_USER_NOT_FOUND":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "ERROR_USER_DISABLED":
            errorMessage = "User with this email has been disabled.";
            break;
          case "ERROR_TOO_MANY_REQUESTS":
            errorMessage = "Too many requests. Try again later.";
            break;
          case "ERROR_OPERATION_NOT_ALLOWED":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        yield LoginFailureState(massage: errorMessage);
      }
    }
  }
}
