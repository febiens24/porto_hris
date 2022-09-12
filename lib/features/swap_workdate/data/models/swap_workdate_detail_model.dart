import '../../../../../core/global/entities/approver_entity.dart';
import '../../../../../core/global/entities/attachment_entity.dart';
import '../../../../core/global/models/approver_model.dart';
import '../../../../core/global/models/attachment_model.dart';
import '../../domain/entities/swap_workdate_detail_entity.dart';

class SwapWorkdateDetailModel extends SwapWorkdateDetailEntity {
  const SwapWorkdateDetailModel({
    required String status,
    required String message,
    required SwapWorkdateDetailResultEntity result,
  }) : super(
          status: status,
          message: message,
          result: result,
        );

  factory SwapWorkdateDetailModel.fromJson(Map<String, dynamic> json) =>
      SwapWorkdateDetailModel(
        status: json['status'],
        message: json['message'],
        result: SwapWorkdateDetailResultModel.fromJson(json['result']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result,
      };
}

class SwapWorkdateDetailResultModel extends SwapWorkdateDetailResultEntity {
  const SwapWorkdateDetailResultModel({
    required int swapWorkdateId,
    required String swapWorkdateDocumentNumber,
    required String swapWorkdateRequesterName,
    required String swapWorkdateProfilePicture,
    required String swapWorkdateRequesterRole,
    required String swapWorkdateStatus,
    required String swapWorkdateWorkdate,
    required String swapWorkdateNewDate,
    required String swapWorkdateNotes,
    required List<AttachmentEntity> swapWorkdateAttachments,
    required List<ApproverEntity> swapWorkdateApprovers,
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
          swapWorkdateAttachments: swapWorkdateAttachments,
          swapWorkdateApprovers: swapWorkdateApprovers,
        );

  factory SwapWorkdateDetailResultModel.fromJson(Map<String, dynamic> json) =>
      SwapWorkdateDetailResultModel(
        swapWorkdateId: json['SwapWorkdateId'] as int,
        swapWorkdateDocumentNumber:
            json['SwapWorkdateDocumentNumber'] as String,
        swapWorkdateRequesterName: json['SwapWorkdateRequesterName'] as String,
        swapWorkdateProfilePicture:
            json['SwapWorkdateProfilePicture'] as String,
        swapWorkdateRequesterRole: json['SwapWorkdateRequesterRole'] as String,
        swapWorkdateStatus: json['SwapWorkdateStatus'] as String,
        swapWorkdateWorkdate: json['SwapWorkdateWorkdate'] as String,
        swapWorkdateNewDate: json['SwapWorkdateNewDate'] as String,
        swapWorkdateNotes: json['SwapWorkdateNotes'] as String,
        swapWorkdateAttachments:
            (json['SwapWorkdateAttachments'] as List<dynamic>)
                .map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
                .toList(),
        swapWorkdateApprovers: (json['SwapWorkdateApprovers'] as List<dynamic>)
            .map((e) => ApproverModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'SwapWorkdateId': swapWorkdateId,
        'SwapWorkdateDocumentNumber': swapWorkdateDocumentNumber,
        'SwapWorkdateRequesterName': swapWorkdateRequesterName,
        'SwapWorkdateProfilePicture': swapWorkdateProfilePicture,
        'SwapWorkdateRequesterRole': swapWorkdateRequesterRole,
        'SwapWorkdateStatus': swapWorkdateStatus,
        'SwapWorkdateWorkdate': swapWorkdateWorkdate,
        'SwapWorkdateNewDate': swapWorkdateNewDate,
        'SwapWorkdateNotes': swapWorkdateNotes,
        'SwapWorkdateAttachments': swapWorkdateAttachments,
        'SwapWorkdateApprovers': swapWorkdateApprovers,
      };
}
