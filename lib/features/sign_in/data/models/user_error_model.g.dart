// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserErrorModel _$UserErrorModelFromJson(Map<String, dynamic> json) =>
    UserErrorModel(
      status: json['status'] as String,
      result: json['result'] as String?,
    );

Map<String, dynamic> _$UserErrorModelToJson(UserErrorModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };
