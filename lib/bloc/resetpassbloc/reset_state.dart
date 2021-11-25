import 'package:equatable/equatable.dart';

abstract class ResetState extends Equatable {}

class ResetInitial extends ResetState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ResetLoading extends ResetState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ResetSuccess extends ResetState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ResetFailure extends ResetState {
  String message;
  ResetFailure({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
