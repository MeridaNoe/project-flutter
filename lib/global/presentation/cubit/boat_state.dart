import 'package:equatable/equatable.dart';
import '../../../data/model/BoatModel.dart';

abstract class BoatState extends Equatable {
  const BoatState();

  @override
  List<Object> get props => [];
}

class BoatInitial extends BoatState {}

class BoatLoading extends BoatState {}

class BoatSuccess extends BoatState {
  final List<BoatModel> boats;

  const BoatSuccess(this.boats);

  @override
  List<Object> get props => [boats];
}

class BoatError extends BoatState {
  final String message;

  const BoatError(this.message);

  @override
  List<Object> get props => [message];
}