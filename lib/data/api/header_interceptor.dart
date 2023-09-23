import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:daily_dogs/util/huh.dart';

class HeaderInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) {
    final headers = request.headers;
    headers['x-api-key'] = apiKey;
    Request newRequest = request.copyWith(
      headers: headers,
    );
    return newRequest;
  }
}

const apiKey = 'live_OWXbYSTDtAOAlvRZHydWrS0jMDCfclQrijE78Fw3w1i6gRNbY98FprMnkc7coKbV';

const JsonMap apiKeyMap = {
  'apiKey': apiKey,
};
