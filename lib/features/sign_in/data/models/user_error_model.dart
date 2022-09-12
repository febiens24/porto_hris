import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user_error_entity.dart';

part 'user_error_model.g.dart';

@JsonSerializable()
class UserErrorModel extends UserErrorEntity {
  const UserErrorModel({
    required String status,
    required String? result,
  }) : super(
          status: status,
          result: result,
        );
  factory UserErrorModel.fromJson(Map<String, dynamic> json) {
    return _$UserErrorModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserErrorModelToJson(this);
}
