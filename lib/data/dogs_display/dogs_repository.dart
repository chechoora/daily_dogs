import 'package:daily_dogs/data/api/dog_api_service.dart';
import 'package:daily_dogs/data/dogs_display/dog_mapper.dart';
import 'package:daily_dogs/data/dogs_display/dog_model.dart';

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
      if (body is String) {
        return dogMapper.mapFromResponse(body);
      }
    }
    return [];
  }
}
