// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_datasource.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _SignInApiServices implements SignInApiServices {
  _SignInApiServices(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://10.1.10.12:3000';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Map<String, dynamic>> staffLogin(username, password) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'CLient-Id': 'J3jBYBugBPW7mAdrVN1y86YFvmJ6lV',
      r'Client-Secret': '4g5cBCYnfqMYQhWrnl6l433xmXxRAsYmFzEn',
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'username': username, 'password': password};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, dynamic>>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, '/login',
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
