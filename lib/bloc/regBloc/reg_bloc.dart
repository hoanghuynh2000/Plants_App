import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/bloc/regBloc/reg_event.dart';
import 'package:plants_app/bloc/regBloc/reg_state.dart';
import 'package:plants_app/respository/user_respon.dart';

class UserRegBloc extends Bloc<UserRegEvent, UserRegState> {
  UserResponsitory? userResponsitory;
  UserRegBloc({this.userResponsitory}) : super(UserRegInitial()) {
    userResponsitory = UserResponsitory();
  }
  @override
  Stream<UserRegState> mapEventToState(UserRegEvent event) async* {
    if (event is SignUpButtonOnPressEvent) {
      try {
        yield UserLoadingState();
        var user =
            await userResponsitory!.CreateUser(event.email, event.password);
        var userStore =
            await userResponsitory!.userSetup(event.name, event.phoneNumber);
        var userLogin =
            await userResponsitory!.SignInUser(event.email, event.password);
        yield UserRegSuccessful(user: user!);
      } catch (e) {
        yield UserRegFailure(massage: e.toString());
      }
    }
  }
}
