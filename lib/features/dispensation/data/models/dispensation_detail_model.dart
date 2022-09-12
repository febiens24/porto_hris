import '../../../../../core/global/entities/approver_entity.dart';
import '../../../../../core/global/entities/attachment_entity.dart';
import '../../../../../core/global/models/approver_model.dart';
import '../../../../../core/global/models/attachment_model.dart';
import '../../domain/entities/dispensation_detail_entity.dart';

class DispensationDetailModel extends DispensationDetailEntity {
  const DispensationDetailModel({
    required String status,
    required String message,
    required DispensationDetailResultEntity result,
  }) : super(
          status: status,
          message: message,
          result: result,
        );

  factory DispensationDetailModel.fromJson(Map<String, dynamic> json) =>
      DispensationDetailModel(
        status: json['status'],
        message: json['message'],
        result: DispensationDetailResultModel.fromJson(json['result']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result,
      };
}

class DispensationDetailResultModel extends DispensationDetailResultEntity {
  const DispensationDetailResultModel({
    required int dispensationId,
    required String dispensationDocumentNumber,
    required String dispensationRequesterName,
    required String dispensationRequesterProfilePicture,
    required String dispensationRequesterRole,
    required String dispensationStatus,
    required String dispensationRequestDate,
    required String dispensationType,
    required String dispensationDate,
    required String dispensationClockType,
    required String dispensationNotes,
    required List<AttachmentEntity> dispensationAttachments,
    required List<ApproverEntity> dispensationApprovers,
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
          dispensationDate: dispensationDate,
          dispensationClockType: dispensationClockType,
          dispensationNotes: dispensationNotes,
          dispensationAttachments: dispensationAttachments,
          dispensationApprovers: dispensationApprovers,
        );

  factory DispensationDetailResultModel.fromJson(Map<String, dynamic> json) =>
      DispensationDetailResultModel(
        dispensationId: json["DispensationId"] as int,
        dispensationDocumentNumber:
            json["DispensationDocumentNumber"] as String,
        dispensationRequesterName: json["DispensationRequesterName"] as String,
        dispensationRequesterProfilePicture:
            json["DispensationRequesterProfilePicture"] as String,
        dispensationRequesterRole: json["DispensationRequesterRole"] as String,
        dispensationStatus: json["DispensationStatus"] as String,
        dispensationRequestDate: json["DispensationRequestDate"] as String,
        dispensationType: json["DispensationType"] as String,
        dispensationDate: json["DispensationDate"] as String,
        dispensationClockType: json["DispensationClockType"] as String,
        dispensationNotes: json["DispensationNotes"] as String,
        dispensationAttachments:
            (json['DispensationAttachments'] as List<dynamic>)
                .map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
                .toList(),
        dispensationApprovers: (json['DispensationApprovers'] as List<dynamic>)
            .map((e) => ApproverModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "DispensationId": dispensationId,
        "DispensationDocumentNumber": dispensationDocumentNumber,
        "DispensationRequesterName": dispensationRequesterName,
        "DispensationRequesterProfilePicture":
            dispensationRequesterProfilePicture,
        "DispensationRequesterRole": dispensationRequesterRole,
        "DispensationStatus": dispensationStatus,
        "DispensationRequestDate": dispensationRequestDate,
        "DispensationType": dispensationType,
        "DispensationDate": dispensationDate,
        "DispensationClockType": dispensationClockType,
        "DispensationNotes": dispensationNotes,
        "DispensationAttachments": dispensationAttachments,
        "DispensationApprovers": dispensationApprovers,
      };
}
