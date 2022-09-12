import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const _defaultConnectTimeOut = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

Dio getDio() {
  Dio dio = Dio();
  dio
    ..options.connectTimeout = _defaultConnectTimeOut
    ..options.receiveTimeout = _defaultReceiveTimeout;
  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
  ));
  return dio;
}
