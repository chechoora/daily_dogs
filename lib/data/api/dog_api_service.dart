import 'package:chopper/chopper.dart';

part "dog_api_service.chopper.dart";

@ChopperApi(baseUrl: "/images/search")
abstract class DogApiService extends ChopperService {
  static DogApiService create([ChopperClient? client]) => _$DogApiService(client);

  @Get()
  Future<Response> searchRandomImages({
    @Query("page") int page = 0,
    @Query("limit") int limit = 10,
  });
}
