import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SimpleLoadingWidget extends StatelessWidget {
  const SimpleLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      child: const SpinKitHourGlass(
        color: Colors.orangeAccent,
        size: 32,
      ),
    );
  }
}
