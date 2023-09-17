import 'package:flutter/material.dart';

class DataDisplayWidget extends StatelessWidget {
  const DataDisplayWidget({
    required this.displayList,
    this.onLongPress,
    this.onRefreshPulled,
    super.key,
  });

  final List<DisplayModel> displayList;
  final ValueChanged<DisplayModel>? onLongPress;
  final VoidCallback? onRefreshPulled;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefreshPulled?.call();
      },
      child: GridView.count(
        crossAxisCount: 2,
        children: displayList.map((model) {
          return InkWell(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Image.network(model.displayImage),
            ),
            onLongPress: () {
              onLongPress?.call(model);
            },
          );
        }).toList(),
      ),
    );
  }
}

class DisplayModel {
  final String id;
  final String displayImage;

  DisplayModel(this.id, this.displayImage);
}
