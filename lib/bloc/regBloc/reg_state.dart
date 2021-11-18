import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRegState extends Equatable {}

class UserRegInitial extends UserRegState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class UserLoadingState extends UserRegState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class UserRegSuccessful extends UserRegState {
  User user;
  UserRegSuccessful({required this.user});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class UserRegFailure extends UserRegState {
  String? massage;
  UserRegFailure({required this.massage});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
