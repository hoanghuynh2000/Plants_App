
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/couter/event.dart';

class CouterBloc extends Bloc<CouterEvent, int> {
  CouterBloc() : super(1);
  @override
  int get initialState => 1;
  @override
  Stream<int> mapEventToState(CouterEvent event) async* {
    switch (event) {
      case CouterEvent.incre:
        var newstate = state + 1;
        if (newstate > 5) {
          newstate = 5;
        }

        yield newstate;
        break;
      case CouterEvent.decre:
        var newstate = state - 1;
        if (newstate < 1) {
          newstate = 1;
        }

        yield newstate;
        break;
      default:
    }
  }
}
