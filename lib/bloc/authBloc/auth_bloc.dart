import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/bloc/authBloc/auth_event.dart';
import 'package:plants_app/bloc/authBloc/auth_state.dart';
import 'package:plants_app/respository/user_respon.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserResponsitory? userResponsitory;

  AuthBloc() : super(AuthInitalState()) {
    this.userResponsitory = UserResponsitory();
  }
  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStartedEvent) {
      try {
        var isSignin = await userResponsitory!.IsSignIn();
        if (isSignin) {
          var user = await userResponsitory!.getCurrentUser();
          yield AuthenticatedState(user: user);
        } else {
          yield UnAuthenticatedState();
        }
      } catch (e) {
        yield UnAuthenticatedState();
      }
    }
  }
}
