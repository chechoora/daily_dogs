import 'dart:convert';

import 'package:daily_dogs/data/dogs_display/dog_model.dart';

class DogMapper {
  List<DogModel> mapFromResponse(String responseBody) {
    final jsonResponse = jsonDecode(responseBody);
    if (jsonResponse is List) {
      final resultList = <DogModel>[];
      for (var value in jsonResponse) {
        resultList.add(
          DogModel(
            id: value['id'],
            imageUrl: value['url'],
          ),
        );
      }
      return resultList;
    }
    return [];
  }
}
