import 'package:daily_dogs/data/dogs_display/dogs_repository.dart';
import 'package:daily_dogs/di.dart';
import 'package:daily_dogs/favorites_display/bloc/favorites_display_bloc.dart';
import 'package:daily_dogs/util/data_display_widget.dart';
import 'package:daily_dogs/util/simple_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesDisplayWidget extends StatefulWidget {
  const FavoritesDisplayWidget({super.key});

  @override
  State<FavoritesDisplayWidget> createState() => _FavoritesDisplayWidgetState();
}

class _FavoritesDisplayWidgetState extends State<FavoritesDisplayWidget> with AutomaticKeepAliveClientMixin {
  late final FavoritesDisplayBloc _bloc;

  @override
  void initState() {
    _bloc = FavoritesDisplayBloc(dogsRepository: getIt<DogsRepository>())..add(FetchFavoriteDogsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<FavoritesDisplayBloc, FavoritesDisplayState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is LoadingState) {
          return const SimpleLoadingWidget();
        }
        if (state is DataState) {
          return DataDisplayWidget(
            displayList: state.favoriteDogDisplayList.map((e) => DisplayModel(e.id, e.imageUrl)).toList(),
            onLongPress: (model) {
              _bloc.add(RemoveFromFavoritesEvent(model.id));
            },
            onRefreshPulled: () {
              _bloc.add(FetchFavoriteDogsEvent());
            },
          );
        }
        throw ArgumentError('Widget for state $state is not implemented');
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
