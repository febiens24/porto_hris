import '../../../../../core/global/entities/approver_entity.dart';
import '../../../../../core/global/entities/attachment_entity.dart';
import '../../../../core/global/models/approver_model.dart';
import '../../../../core/global/models/attachment_model.dart';
import '../../domain/entities/reprimand_detail_entity.dart';

class ReprimandDetailModel extends ReprimandDetailEntity {
  const ReprimandDetailModel({
    required String status,
    required String message,
    required ReprimandDetailResultEntity result,
  }) : super(
          status: status,
          message: message,
          result: result,
        );

  factory ReprimandDetailModel.fromJson(Map<String, dynamic> json) =>
      ReprimandDetailModel(
        status: json['status'],
        message: json['message'],
        result: ReprimandDetailResultModel.fromJson(json['result']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result,
      };
}

class ReprimandDetailResultModel extends ReprimandDetailResultEntity {
  const ReprimandDetailResultModel({
    required int reprimandId,
    required String reprimandNumber,
    required String reprimandRequesterName,
    required String reprimandProfilePicture,
    required String reprimandRequesterRole,
    required String reprimandStatus,
    required String reprimandType,
    required String reprimandEffectiveDate,
    required String reprimandExpirationDate,
    required String reprimandNotes,
    required List<AttachmentEntity> reprimandAttachments,
    required List<ApproverEntity> reprimandApprovers,
  }) : super(
          reprimandId: reprimandId,
          reprimandNumber: reprimandNumber,
          reprimandRequesterName: reprimandRequesterName,
          reprimandProfilePicture: reprimandProfilePicture,
          reprimandRequesterRole: reprimandRequesterRole,
          reprimandStatus: reprimandStatus,
          reprimandType: reprimandType,
          reprimandEffectiveDate: reprimandEffectiveDate,
          reprimandExpirationDate: reprimandExpirationDate,
          reprimandNotes: reprimandNotes,
          reprimandAttachments: reprimandAttachments,
          reprimandApprovers: reprimandApprovers,
        );

  factory ReprimandDetailResultModel.fromJson(Map<String, dynamic> json) =>
      ReprimandDetailResultModel(
        reprimandId: json['ReprimandId'] as int,
        reprimandNumber: json['ReprimandDocumentNumber'] as String,
        reprimandRequesterName: json['ReprimandRequesterName'] as String,
        reprimandProfilePicture: json['ReprimandProfilePicture'] as String,
        reprimandRequesterRole: json['ReprimandRequesterRole'] as String,
        reprimandStatus: json['ReprimandStatus'] as String,
        reprimandType: json['ReprimandType'] as String,
        reprimandEffectiveDate: json['ReprimandEffectiveDate'] as String,
        reprimandExpirationDate: json['ReprimandExpirationDate'] as String,
        reprimandNotes: json['ReprimandNotes'] as String,
        reprimandAttachments: (json['ReprimandAttachments'] as List<dynamic>)
            .map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        reprimandApprovers: (json['ReprimandApprovers'] as List<dynamic>)
            .map((e) => ApproverModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'ReprimandId': reprimandId,
        'ReprimandNumber': reprimandNumber,
        'ReprimandRequesterName': reprimandRequesterName,
        'ReprimandProfilePicture': reprimandProfilePicture,
        'ReprimandRequesterRole': reprimandRequesterRole,
        'ReprimandStatus': reprimandStatus,
        'ReprimandType': reprimandType,
        'ReprimandEffectiveDate': reprimandEffectiveDate,
        'ReprimandExpirationDate': reprimandExpirationDate,
        'ReprimandNotes': reprimandNotes,
        'ReprimandAttachments': reprimandAttachments,
        'ReprimandApprovers': reprimandApprovers,
      };
}
