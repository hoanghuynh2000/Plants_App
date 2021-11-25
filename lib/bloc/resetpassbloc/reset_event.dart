import 'package:equatable/equatable.dart';

abstract class ResetEvent extends Equatable {}

class ResetButtonOnPressEvent extends ResetEvent {
  String? email;
  ResetButtonOnPressEvent({required this.email});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
