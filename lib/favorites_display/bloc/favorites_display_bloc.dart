import 'dart:async';

import 'package:daily_dogs/data/dogs_display/dogs_repository.dart';
import 'package:daily_dogs/data/favorites_display/favorite_dog_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesDisplayBloc extends Bloc<FavoritesDisplayEvent, FavoritesDisplayState> {
  FavoritesDisplayBloc({
    required this.dogsRepository,
  }) : super(LoadingState()) {
    on<FetchFavoriteDogsEvent>(_onFetchFavoriteDogsEvent);
    on<RemoveFromFavoritesEvent>(_onRemoveFromFavoritesEvent);
  }

  final DogsRepository dogsRepository;

  List<FavoriteDogModel>? _displayList;

  List<FavoriteDogModel> get _displayListSafe => _displayList ?? [];

  FutureOr<void> _onFetchFavoriteDogsEvent(
    FetchFavoriteDogsEvent event,
    Emitter<FavoritesDisplayState> emit,
  ) async {
    emit(LoadingState());
    _displayList = await dogsRepository.fetchFavoriteDogs();
    emit(DataState(_displayListSafe));
  }

  FutureOr<void> _onRemoveFromFavoritesEvent(
    RemoveFromFavoritesEvent event,
    Emitter<FavoritesDisplayState> emit,
  ) async {
    emit(LoadingState());
    final result = await dogsRepository.removeFromFavorites(event.id);
    if (result) {
      _displayList = await dogsRepository.fetchFavoriteDogs();
    }
    emit(DataState(_displayListSafe));
  }
}

abstract class FavoritesDisplayState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingState extends FavoritesDisplayState {}

class DataState extends FavoritesDisplayState {
  final List<FavoriteDogModel> favoriteDogDisplayList;

  DataState(this.favoriteDogDisplayList);

  @override
  List<Object?> get props => [favoriteDogDisplayList];
}

abstract class FavoritesDisplayEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchFavoriteDogsEvent extends FavoritesDisplayEvent {
  @override
  List<Object?> get props => [double.nan];
}

class RemoveFromFavoritesEvent extends FavoritesDisplayEvent {
  final String id;

  RemoveFromFavoritesEvent(this.id);
}
