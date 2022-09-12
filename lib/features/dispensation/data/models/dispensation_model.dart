import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/dispensation_entity.dart';

part 'dispensation_model.g.dart';

class DispensationModel extends DispensationEntity {
  const DispensationModel({
    required String status,
    required String message,
    required List<DispensationResultEntity> result,
    List<dynamic>? types,
  }) : super(
          status: status,
          message: message,
          result: result,
          types: types,
        );

  factory DispensationModel.fromJson(Map<String, dynamic> json) =>
      DispensationModel(
        status: json['status'],
        message: json['message'],
        result: (json['result'] as List<dynamic>)
            .map((e) =>
                DispensationResultModel.fromJson(e as Map<String, dynamic>))
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
class DispensationResultModel extends DispensationResultEntity {
  const DispensationResultModel({
    required int dispensationId,
    required String dispensationDocumentNumber,
    String? dispensationRequesterName,
    String? dispensationRequesterProfilePicture,
    String? dispensationRequesterRole,
    required String dispensationStatus,
    required String dispensationRequestDate,
    required String dispensationType,
    String? dispensationClockType,
    required String dispensationDate,
  }) : super(
          dispensationId: dispensationId,
          dispensationDocumentNumber: dispensationDocumentNumber,
          dispensationRequesterName: dispensationRequesterName,
          dispensationRequesterProfilePicture:
              dispensationRequesterProfilePicture,
          dispensationRequesterRole: dispensationRequesterRole,
          dispensationStatus: dispensationStatus,
          dispensationRequestDate: dispensationRequestDate,
          dispensationType: dispensationType,
          dispensationClockType: dispensationClockType,
          dispensationDate: dispensationDate,
        );

  factory DispensationResultModel.fromJson(Map<String, dynamic> json) =>
      _$DispensationResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$DispensationResultModelToJson(this);
}
