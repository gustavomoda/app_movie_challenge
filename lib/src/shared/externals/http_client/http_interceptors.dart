import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../app_logger.dart';

@prod
@dev
@singleton
class AppHttpInterceptors extends Interceptor {
  AppHttpInterceptors(this.logger);

  final AppLogger logger;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    logger.d(
      'Requesting  ${options.method} ${options.uri}: '
      '\n\t headers=${options.headers}'
      '\n\t queryParameters=${options.queryParameters}'
      '\n\t body=${options.data}',
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('${response.statusCode} ${response.realUri}'
        '\n\t request_data=${response.requestOptions.data}'
        '\n\t queryParameters=${response.requestOptions.queryParameters}'
        '\n\tresponse_data=${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.d(
      'Error Request: ${err.requestOptions.method} ${err.requestOptions.uri}: '
      '\n\t headers=${err.requestOptions.headers}'
      '\n\t queryParameters=${err.requestOptions.queryParameters}'
      '\n\t error type=${err.type}'
      '\n\t error=${err.error}'
      '\n\t response=${err.response?.data}',
    );
    super.onError(err, handler);
  }
}
