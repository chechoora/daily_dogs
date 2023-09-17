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
    on<AddToFavoritesEvent>(_onAddToFavoritesEvent);
  }

  final DogsRepository dogsRepository;

  FutureOr<void> _onFetchRandomDogsEvent(
    FetchRandomDogsEvent event,
    Emitter<DogsDisplayState> emit,
  ) async {
    emit(LoadingState());
    final randomDogs = await dogsRepository.fetchRandomDogs();
    emit(DataState(randomDogs));
  }

  FutureOr<void> _onAddToFavoritesEvent(
    AddToFavoritesEvent event,
    Emitter<DogsDisplayState> emit,
  ) async {
    emit(NotifyState('Adding doge to favorites'));
    await dogsRepository.addDogToFavorites(event.id);
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

  @override
  List<Object?> get props => [dogDisplayList];
}

class NotifyState extends DogsDisplayState {
  final String message;

  NotifyState(this.message);
}

abstract class DogsDisplayEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchRandomDogsEvent extends DogsDisplayEvent {
  @override
  List<Object?> get props => [double.nan];
}

class AddToFavoritesEvent extends DogsDisplayEvent {
  final String id;

  AddToFavoritesEvent(this.id);

  @override
  List<Object?> get props => [id];
}
