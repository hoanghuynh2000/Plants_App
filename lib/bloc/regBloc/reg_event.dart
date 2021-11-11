import 'package:equatable/equatable.dart';

abstract class UserRegEvent extends Equatable {}

class SignUpButtonOnPressEvent extends UserRegEvent {
  String email, password, name, phoneNumber;
  SignUpButtonOnPressEvent(
      {required this.email,
      required this.password,
      required this.name,
      required this.phoneNumber});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
