import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/reprimand_entity.dart';

part 'reprimand_model.g.dart';

class ReprimandModel extends ReprimandEntity {
  const ReprimandModel({
    required String status,
    required String message,
    List<ReprimandResultEntity>? result,
    List<dynamic>? types,
  }) : super(
          status: status,
          message: message,
          result: result,
          types: types,
        );

  factory ReprimandModel.fromJson(Map<String, dynamic> json) => ReprimandModel(
        status: json['status'],
        message: json['message'],
        result: (json['result'] as List<dynamic>?)
            ?.map(
                (e) => ReprimandResultModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        types: json['types'],
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result,
        'types': types,
      };
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class ReprimandResultModel extends ReprimandResultEntity {
  const ReprimandResultModel({
    required int reprimandId,
    required String reprimandDocumentNumber,
    String? reprimandRequesterName,
    String? reprimandProfilePicture,
    String? reprimandRequesterRole,
    required String reprimandStatus,
    required String reprimandType,
    required String reprimandEffectiveDate,
    required String reprimandExpirationDate,
    required String reprimandNotes,
  }) : super(
          reprimandId: reprimandId,
          reprimandDocumentNumber: reprimandDocumentNumber,
          reprimandRequesterName: reprimandRequesterName,
          reprimandProfilePicture: reprimandProfilePicture,
          reprimandRequesterRole: reprimandRequesterRole,
          reprimandStatus: reprimandStatus,
          reprimandType: reprimandType,
          reprimandEffectiveDate: reprimandEffectiveDate,
          reprimandExpirationDate: reprimandExpirationDate,
          reprimandNotes: reprimandNotes,
        );

  factory ReprimandResultModel.fromJson(Map<String, dynamic> json) =>
      _$ReprimandResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReprimandResultModelToJson(this);
}
