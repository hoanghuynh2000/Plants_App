import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/bloc/drawerBloc/drawer_event.dart';
import 'package:plants_app/bloc/drawerBloc/drawer_state.dart';
import 'package:plants_app/respository/user_respon.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  UserResponsitory? userResponsitory;

  DrawerBloc({this.userResponsitory}) : super(LogoutInitialState()) {
    this.userResponsitory = UserResponsitory();
  }
  @override
  Stream<DrawerState> mapEventToState(DrawerEvent event) async* {
    if (event is LogOutButtonOnPressState) {
      await userResponsitory!.SignOut();
      yield LogoutSuccessfulState();
    }
  }
}
