import 'package:daily_dogs/data/dogs_display/dogs_repository.dart';
import 'package:daily_dogs/di.dart';
import 'package:daily_dogs/dogs_display/bloc/dogs_display_bloc.dart';
import 'package:daily_dogs/util/data_display_widget.dart';
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
          return DataDisplayWidget(
            displayList: state.dogDisplayList.map(
              (e) {
                return DisplayModel(e.id, e.imageUrl);
              },
            ).toList(),
            onLongPress: (model) {
              _bloc.add(AddToFavoritesEvent(model.id));
            },
            onRefreshPulled: () {
              _bloc.add(FetchRandomDogsEvent());
            },
          );
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
}
