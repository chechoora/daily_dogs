import 'package:daily_dogs/data/dogs_display/dogs_repository.dart';
import 'package:daily_dogs/di.dart';
import 'package:daily_dogs/dogs_display/bloc/dogs_display_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogsDisplayWidget extends StatefulWidget {
  const DogsDisplayWidget({super.key});

  @override
  State<DogsDisplayWidget> createState() => _DogsDisplayWidgetState();
}

class _DogsDisplayWidgetState extends State<DogsDisplayWidget> {
  late final DogsDisplayBloc _bloc;

  @override
  void initState() {
    _bloc = DogsDisplayBloc(dogsRepository: getIt<DogsRepository>())..add(FetchRandomDogsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      buildWhen: (oldState, newState) {
        return newState is LoadingState;
      },
      builder: (context, state) {
        return const Placeholder();
      },
    );
  }
}
