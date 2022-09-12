import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/swap_workdate_entity.dart';

part 'swap_workdate_model.g.dart';

class SwapWorkdateModel extends SwapWorkdateEntity {
  const SwapWorkdateModel({
    required String status,
    required String message,
    List<SwapWorkdateResultEntity>? result,
  }) : super(
          status: status,
          message: message,
          result: result,
        );

  factory SwapWorkdateModel.fromJson(Map<String, dynamic> json) =>
      SwapWorkdateModel(
        status: json['status'],
        message: json['message'],
        result: (json['result'] as List<dynamic>?)
            ?.map((e) =>
                SwapWorkdateResultModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result,
      };
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class SwapWorkdateResultModel extends SwapWorkdateResultEntity {
  const SwapWorkdateResultModel({
    required int swapWorkdateId,
    required String swapWorkdateDocumentNumber,
    String? swapWorkdateRequesterName,
    String? swapWorkdateProfilePicture,
    String? swapWorkdateRequesterRole,
    required String swapWorkdateStatus,
    required String swapWorkdateWorkdate,
    required String swapWorkdateNewDate,
    required String swapWorkdateNotes,
  }) : super(
          swapWorkdateId: swapWorkdateId,
          swapWorkdateDocumentNumber: swapWorkdateDocumentNumber,
          swapWorkdateRequesterName: swapWorkdateRequesterName,
          swapWorkdateProfilePicture: swapWorkdateProfilePicture,
          swapWorkdateRequesterRole: swapWorkdateRequesterRole,
          swapWorkdateStatus: swapWorkdateStatus,
          swapWorkdateWorkdate: swapWorkdateWorkdate,
          swapWorkdateNewDate: swapWorkdateNewDate,
          swapWorkdateNotes: swapWorkdateNotes,
        );

  factory SwapWorkdateResultModel.fromJson(Map<String, dynamic> json) =>
      _$SwapWorkdateResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$SwapWorkdateResultModelToJson(this);
}
