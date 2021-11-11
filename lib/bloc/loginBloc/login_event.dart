import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

class LoginButtonOnPressEvent extends LoginEvent {
  String? email, password;
  LoginButtonOnPressEvent({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
