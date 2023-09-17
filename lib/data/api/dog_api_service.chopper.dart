// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dog_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_string_interpolations, unnecessary_brace_in_string_interps
final class _$DogApiService extends DogApiService {
  _$DogApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = DogApiService;

  @override
  Future<Response<dynamic>> searchRandomImages({
    int page = 0,
    int limit = 10,
  }) {
    final Uri $url = Uri.parse('/images/search');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> fetchFavorites() {
    final Uri $url = Uri.parse('/favourites');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addToFavorites(
      {required Map<String, dynamic> body}) {
    final Uri $url = Uri.parse('/favourites');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> removeFromFavorites({required String favoriteId}) {
    final Uri $url = Uri.parse('/favourites/${favoriteId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
