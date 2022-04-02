import 'package:dio/dio.dart';

class TrafficInterceptor extends Interceptor {
  final accessToken =
      'pk.eyJ1IjoiamF2aWVyOTgwNTA2MDIiLCJhIjoiY2wxNndic2xuMTczNzNscnRqbTM4aGs4cSJ9.0NM8fKs3EW2NHo-ocq2UJw';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken
    });

    super.onRequest(options, handler);
  }
}
