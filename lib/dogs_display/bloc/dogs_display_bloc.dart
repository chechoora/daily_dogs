import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogsDisplayBloc extends Bloc<DogsDisplayEvent, DogsDisplayState> {
  DogsDisplayBloc() : super(LoadingState());
}

abstract class DogsDisplayState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingState extends DogsDisplayState {}

abstract class DogsDisplayEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchRandomDogsEvent extends DogsDisplayEvent {}
