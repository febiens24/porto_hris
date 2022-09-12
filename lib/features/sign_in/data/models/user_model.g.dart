// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResultModel _$UserResultModelFromJson(Map<String, dynamic> json) =>
    UserResultModel(
      userName: json['UserName'] as String,
      userType: json['UserType'] as String,
      userPartnerId: json['UserPartnerId'] as int,
      userPartnerImage: json['UserPartnerImage'] as String,
      userPartnerEmail: json['UserPartnerEmail'] as String,
      userLogin: json['UserLogin'] as String,
      userPartnerPhone: json['UserPartnerPhone'] as String,
      userId: json['UserId'] as String,
    );

Map<String, dynamic> _$UserResultModelToJson(UserResultModel instance) =>
    <String, dynamic>{
      'UserName': instance.userName,
      'UserType': instance.userType,
      'UserPartnerId': instance.userPartnerId,
      'UserPartnerImage': instance.userPartnerImage,
      'UserPartnerEmail': instance.userPartnerEmail,
      'UserLogin': instance.userLogin,
      'UserPartnerPhone': instance.userPartnerPhone,
      'UserId': instance.userId,
    };
