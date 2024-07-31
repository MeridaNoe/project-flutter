import 'package:equatable/equatable.dart';
import '../../../data/model//PersonModel.dart';

abstract class PersonState extends Equatable {
  @override
  List<Object> get props => [];
}

class PersonInitial extends PersonState {}

class PersonLoading extends PersonState {}

class PersonSuccess extends PersonState {
  final List<PersonModel> person;

  PersonSuccess({required this.person});

  @override
  List<Object> get props => [person];
}

class PersonError extends PersonState {
  final String message;

  PersonError({required this.message});

  @override
  List<Object> get props => [message];
}