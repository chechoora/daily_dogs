import 'package:daily_dogs/data/dogs_display/dog_model.dart';
import 'package:daily_dogs/data/favorites_display/favorite_dog_model.dart';

class DogMapper {
  List<DogModel> mapSearchFromResponse(List<dynamic> jsonResponse) {
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

  List<FavoriteDogModel> mapFavoritesFromResponse(List<dynamic> jsonResponse) {
    final resultList = <FavoriteDogModel>[];
    for (var value in jsonResponse) {
      final Map? image = value['image'];
      if (image != null) {
        resultList.add(
          FavoriteDogModel(
            id: value['id'].toString(),
            imageId: image['id'],
            imageUrl: image['url'],
          ),
        );
      }
    }
    return resultList;
  }
}
