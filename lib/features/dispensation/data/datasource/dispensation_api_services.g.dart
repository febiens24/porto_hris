// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dispensation_api_services.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _DispensationApiServices implements DispensationApiServices {
  _DispensationApiServices(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://10.1.10.12:3000';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Map<String, dynamic>> fetchDispensationList(userid,
      {status, type, dateFrom, dateTo, q, page}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'filter[status]': status,
      r'filter[type]': type,
      r'filter[dateFrom]': dateFrom,
      r'filter[dateTo]': dateTo,
      r'search[q]': q,
      r'page': page
    };
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
                .compose(_dio.options, '/api/v1/hris_dispensation',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!;
    return value;
  }

  @override
  Future<Map<String, dynamic>> fetchDispensationApprovalList(userid) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
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
                .compose(_dio.options, '/api/v1/hris_dispensation/approval',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!;
    return value;
  }

  @override
  Future<Map<String, dynamic>> fetchDispensationApprovalHistoryList(userid,
      {status, type, dateFrom, dateTo, q, page}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'filter[status]': status,
      r'filter[type]': type,
      r'filter[dateFrom]': dateFrom,
      r'filter[dateTo]': dateTo,
      r'search[q]': q,
      r'page': page
    };
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
                .compose(
                    _dio.options, '/api/v1/hris_dispensation/approval/history',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!;
    return value;
  }

  @override
  Future<Map<String, dynamic>> fetchDispensationDetail(
      userid, dispensationId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
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
                .compose(
                    _dio.options, '/api/v1/hris_dispensation/${dispensationId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!;
    return value;
  }

  @override
  Future<Map<String, dynamic>> patchDispensationStatus(
      userid, dispensationId, state, cancelReason) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'CLient-Id': 'J3jBYBugBPW7mAdrVN1y86YFvmJ6lV',
      r'Client-Secret': '4g5cBCYnfqMYQhWrnl6l433xmXxRAsYmFzEn',
      r'User-id': userid
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'state': state, 'cancelReason': cancelReason};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, dynamic>>(Options(
                method: 'PATCH',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(
                _dio.options, '/api/v1/hris_dispensation/${dispensationId}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!;
    return value;
  }

  @override
  Future<Map<String, dynamic>> patchDispensationApprovalStatus(
      userid, dispensationId, state, rejectReason) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'CLient-Id': 'J3jBYBugBPW7mAdrVN1y86YFvmJ6lV',
      r'Client-Secret': '4g5cBCYnfqMYQhWrnl6l433xmXxRAsYmFzEn',
      r'User-id': userid
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'state': state, 'reason': rejectReason};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, dynamic>>(Options(
                method: 'PATCH',
                headers: _headers,
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options,
                '/api/v1/hris_dispensation/approval/${dispensationId}',
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
