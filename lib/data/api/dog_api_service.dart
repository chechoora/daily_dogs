import 'package:chopper/chopper.dart';
import 'package:daily_dogs/util/huh.dart';

part "dog_api_service.chopper.dart";

@ChopperApi()
abstract class DogApiService extends ChopperService {
  static DogApiService create([ChopperClient? client]) => _$DogApiService(client);

  @Get(path: "/images/search")
  Future<Response> searchRandomImages({
    @Query("page") int page = 0,
    @Query("limit") int limit = 10,
  });

  @Get(path: "/favourites")
  Future<Response> fetchFavorites();

  @Post(path: "/favourites")
  Future<Response> addToFavorites({
    @Body() required JsonMap body,
  });

  @Delete(path: "/favourites/{favoriteId}")
  Future<Response> removeFromFavorites({
    @Path() required String favoriteId,
  });
}
