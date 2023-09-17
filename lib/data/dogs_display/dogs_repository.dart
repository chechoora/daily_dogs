import 'package:daily_dogs/data/api/dog_api_service.dart';
import 'package:daily_dogs/data/dogs_display/dog_mapper.dart';
import 'package:daily_dogs/data/dogs_display/dog_model.dart';
import 'package:daily_dogs/data/favorites_display/favorite_dog_model.dart';

class DogsRepository {
  final DogApiService dogApiService;
  final DogMapper dogMapper;

  DogsRepository({
    required this.dogApiService,
    required this.dogMapper,
  });

  Future<List<DogModel>> fetchRandomDogs() async {
    final response = await dogApiService.searchRandomImages();
    if (response.isSuccessful) {
      final body = response.body;
      return dogMapper.mapSearchFromResponse(body);
    }
    return [];
  }

  Future<bool> addDogToFavorites(String id) async {
    final response = await dogApiService.addToFavorites(
      body: <String, dynamic>{
        "image_id": id,
      },
    );
    if (response.isSuccessful) {
      return true;
    }
    return false;
  }

  Future<List<FavoriteDogModel>> fetchFavoriteDogs() async {
    final response = await dogApiService.fetchFavorites();
    if (response.isSuccessful) {
      final body = response.body;
      return dogMapper.mapFavoritesFromResponse(body);
    }
    return [];
  }

  Future<bool> removeFromFavorites(String id) async {
    final response = await dogApiService.removeFromFavorites(favoriteId: id);
    if (response.isSuccessful) {
      return true;
    }
    return false;
  }
}
