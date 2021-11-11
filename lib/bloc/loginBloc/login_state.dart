import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plants_app/respository/user_respon.dart';

abstract class LoginState extends Equatable {}

class LoginInitialState extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoginLoadingState extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoginSucessfulState extends LoginState {
  User user;
  LoginSucessfulState({required this.user});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoginFailureState extends LoginState {
  String massage;
  LoginFailureState({required this.massage});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
