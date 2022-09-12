import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

// @JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({
    required String status,
    UserResultModel? result,
  }) : super(
          status: status,
          result: result,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'],
      result: UserResultModel.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'result': result,
    };
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class UserResultModel extends UserResultEntity {
  const UserResultModel({
    required String userName,
    required String userType,
    required int userPartnerId,
    required String userPartnerImage,
    required String userPartnerEmail,
    required String userLogin,
    required String userPartnerPhone,
    required String userId,
  }) : super(
          userName: userName,
          userType: userType,
          userPartnerId: userPartnerId,
          userPartnerImage: userPartnerImage,
          userPartnerEmail: userPartnerEmail,
          userLogin: userLogin,
          userPartnerPhone: userPartnerPhone,
          userId: userId,
        );

  factory UserResultModel.fromJson(Map<String, dynamic> json) {
    return _$UserResultModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserResultModelToJson(this);
}
