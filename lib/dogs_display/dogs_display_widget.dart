import 'package:daily_dogs/data/dogs_display/dog_model.dart';
import 'package:daily_dogs/data/dogs_display/dogs_repository.dart';
import 'package:daily_dogs/di.dart';
import 'package:daily_dogs/dogs_display/bloc/dogs_display_bloc.dart';
import 'package:daily_dogs/util/simple_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogsDisplayWidget extends StatefulWidget {
  const DogsDisplayWidget({super.key});

  @override
  State<DogsDisplayWidget> createState() => _DogsDisplayWidgetState();
}

class _DogsDisplayWidgetState extends State<DogsDisplayWidget> with AutomaticKeepAliveClientMixin {
  late final DogsDisplayBloc _bloc;

  @override
  void initState() {
    _bloc = DogsDisplayBloc(dogsRepository: getIt<DogsRepository>())..add(FetchRandomDogsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<DogsDisplayBloc, DogsDisplayState>(
      bloc: _bloc,
      buildWhen: (oldState, newState) {
        return newState is LoadingState || newState is DataState;
      },
      listenWhen: (oldState, newState) {
        return newState is NotifyState;
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return const SimpleLoadingWidget();
        }
        if (state is DataState) {
          return _buildDataState(state.dogDisplayList);
        }
        throw ArgumentError('Widget for state $state is not implemented');
      },
      listener: (context, state) {
        if (state is NotifyState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildDataState(List<DogModel> dogDisplayList) {
    return GridView.count(
      crossAxisCount: 2,
      children: dogDisplayList.map((dog) {
        return InkWell(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Image.network(dog.imageUrl),
          ),
          onLongPress: () {
            _bloc.add(AddToFavoritesEvent(dog.id));
          },
        );
      }).toList(),
    );
  }
}
