import 'dart:async';

import 'package:daily_dogs/data/dogs_display/dog_model.dart';
import 'package:daily_dogs/data/dogs_display/dogs_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogsDisplayBloc extends Bloc<DogsDisplayEvent, DogsDisplayState> {
  DogsDisplayBloc({
    required this.dogsRepository,
  }) : super(LoadingState()) {
    on<FetchRandomDogsEvent>(_onFetchRandomDogsEvent);
  }

  final DogsRepository dogsRepository;

  FutureOr<void> _onFetchRandomDogsEvent(
    FetchRandomDogsEvent event,
    Emitter<DogsDisplayState> emit,
  ) async {
    final randomDogs = await dogsRepository.fetchRandomDogs();
    emit(DataState(randomDogs));
  }
}

abstract class DogsDisplayState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingState extends DogsDisplayState {}

class DataState extends DogsDisplayState {
  final List<DogModel> dogDisplayList;

  DataState(this.dogDisplayList);
}

abstract class DogsDisplayEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchRandomDogsEvent extends DogsDisplayEvent {}
