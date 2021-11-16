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
        yield LoginFailureState(massage: e.toString());
      }
    }
  }
}
