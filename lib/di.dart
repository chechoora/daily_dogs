import 'package:chopper/chopper.dart';
import 'package:daily_dogs/data/api/dog_api_service.dart';
import 'package:daily_dogs/data/dogs_display/dog_mapper.dart';
import 'package:daily_dogs/data/dogs_display/dogs_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDi() {
  _setupAPI();
  _setupRepos();
}

void _setupAPI() {
  final dogApiClient = ChopperClient(
    baseUrl: Uri.parse('https://api.thedogapi.com/v1'),
    services: [
      DogApiService.create(),
    ],
  );
  getIt.registerSingleton<ChopperClient>(dogApiClient);
}

void _setupRepos() {
  final dogApiClient = getIt.get<ChopperClient>();
  final DogsRepository dogsRepository = DogsRepository(
    dogApiService: dogApiClient.getService<DogApiService>(),
    dogMapper: DogMapper(),
  );
  getIt.registerSingleton<DogsRepository>(dogsRepository);
}
