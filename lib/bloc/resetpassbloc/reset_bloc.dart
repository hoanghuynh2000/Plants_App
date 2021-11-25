import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/bloc/resetpassbloc/reset_event.dart';
import 'package:plants_app/bloc/resetpassbloc/reset_state.dart';
import 'package:plants_app/respository/user_respon.dart';

class ResetBloc extends Bloc<ResetEvent, ResetState> {
  UserResponsitory? userResponsitory;
  ResetBloc({this.userResponsitory}) : super(ResetLoading());

  @override
  Stream<ResetState> mapEventToState(ResetEvent event) async* {
    if (event is ResetButtonOnPressEvent) {
      yield ResetLoading();
      try {
        var user = await userResponsitory!.ResetPassword(event.email!);
        yield ResetSuccess();
      } catch (e) {
        yield ResetFailure(message: e.toString());
      }
    }
  }
}
