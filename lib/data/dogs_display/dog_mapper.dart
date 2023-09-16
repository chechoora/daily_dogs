import 'package:daily_dogs/data/dogs_display/dog_model.dart';

class DogMapper {
  List<DogModel> mapFromResponse(List<dynamic> jsonResponse) {
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
}
