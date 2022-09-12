import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/overtime_entity.dart';

part 'overtime_model.g.dart';

class OvertimeModel extends OvertimeEntity {
  const OvertimeModel({
    required String status,
    required String message,
    List<OvertimeResultEntity>? result,
    List<dynamic>? types,
  }) : super(
          status: status,
          message: message,
          result: result,
          types: types,
        );

  factory OvertimeModel.fromJson(Map<String, dynamic> json) => OvertimeModel(
        status: json['status'],
        message: json['message'],
        result: (json['result'] as List<dynamic>?)
            ?.map(
                (e) => OvertimeResultModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        types: json['types'],
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result,
      };
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class OvertimeResultModel extends OvertimeResultEntity {
  const OvertimeResultModel({
    required int overtimeId,
    required String overtimeDocumentNumber,
    String? overtimeRequesterName,
    String? overtimeProfilePicture,
    String? overtimeRequesterRole,
    required String overtimeRequestedDate,
    required String overtimeType,
    required String overtimeStatus,
    String? overtimeDateFrom,
    String? overtimeDateTo,
  }) : super(
          overtimeId: overtimeId,
          overtimeDocumentNumber: overtimeDocumentNumber,
          overtimeRequesterName: overtimeRequesterName,
          overtimeProfilePicture: overtimeProfilePicture,
          overtimeRequesterRole: overtimeRequesterRole,
          overtimeRequestedDate: overtimeRequestedDate,
          overtimeType: overtimeType,
          overtimeStatus: overtimeStatus,
          overtimeDateFrom: overtimeDateFrom,
          overtimeDateTo: overtimeDateTo,
        );

  factory OvertimeResultModel.fromJson(Map<String, dynamic> json) =>
      _$OvertimeResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$OvertimeResultModelToJson(this);
}
