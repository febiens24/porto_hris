// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_api_services.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _HomeApiServices implements HomeApiServices {
  _HomeApiServices(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://10.1.10.12:3000';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Map<String, dynamic>> fetchHomepageAPI(userid, {data}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'get': data};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'CLient-Id': 'J3jBYBugBPW7mAdrVN1y86YFvmJ6lV',
      r'Client-Secret': '4g5cBCYnfqMYQhWrnl6l433xmXxRAsYmFzEn',
      r'User-id': userid
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, dynamic>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/v1/hris',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!;
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
