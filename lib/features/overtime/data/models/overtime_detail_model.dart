import '../../../../../core/global/entities/approver_entity.dart';
import '../../../../../core/global/entities/attachment_entity.dart';
import '../../../../../core/global/models/approver_model.dart';
import '../../../../../core/global/models/attachment_model.dart';
import '../../domain/entities/overtime_detail_entity.dart';

class OvertimeDetailModel extends OvertimeDetailEntity {
  const OvertimeDetailModel({
    required String status,
    required String message,
    required OvertimeDetailResultEntity result,
  }) : super(
          status: status,
          message: message,
          result: result,
        );

  factory OvertimeDetailModel.fromJson(Map<String, dynamic> json) =>
      OvertimeDetailModel(
        status: json['status'],
        message: json['message'],
        result: OvertimeDetailResultModel.fromJson(json['result']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result,
      };
}

class OvertimeDetailResultModel extends OvertimeDetailResultEntity {
  const OvertimeDetailResultModel({
    required int overtimeId,
    required String overtimeDocumentNumber,
    required String overtimeRequesterName,
    required String overtimeProfilePicture,
    required String overtimeRequesterRole,
    required String overtimeRequestDate,
    required String overtimeType,
    required String overtimeStatus,
    required String overtimeStartDate,
    required String overtimeEndDate,
    required String overtimeDuration,
    required String overtimeNotes,
    required List<AttachmentEntity> overtimeAttachments,
    required List<ApproverEntity> overtimeApprovers,
  }) : super(
          overtimeId: overtimeId,
          overtimeDocumentNumber: overtimeDocumentNumber,
          overtimeRequesterName: overtimeRequesterName,
          overtimeProfilePicture: overtimeProfilePicture,
          overtimeRequesterRole: overtimeRequesterRole,
          overtimeRequestDate: overtimeRequestDate,
          overtimeType: overtimeType,
          overtimeStatus: overtimeStatus,
          overtimeStartDate: overtimeStartDate,
          overtimeEndDate: overtimeEndDate,
          overtimeDuration: overtimeDuration,
          overtimeNotes: overtimeNotes,
          overtimeAttachments: overtimeAttachments,
          overtimeApprovers: overtimeApprovers,
        );

  factory OvertimeDetailResultModel.fromJson(Map<String, dynamic> json) =>
      OvertimeDetailResultModel(
        overtimeId: json['OvertimeId'] as int,
        overtimeDocumentNumber: json['OvertimeDocumentNumber'] as String,
        overtimeRequesterName: json['OvertimeRequesterName'] as String,
        overtimeProfilePicture: json['OvertimeProfilePicture'] as String,
        overtimeRequesterRole: json['OvertimeRequesterRole'] as String,
        overtimeRequestDate: json['OvertimeRequestDate'] as String,
        overtimeType: json['OvertimeType'] as String,
        overtimeStatus: json['OvertimeStatus'] as String,
        overtimeStartDate: json['OvertimeStartDate'] as String,
        overtimeEndDate: json['OvertimeEndDate'] as String,
        overtimeDuration: json['OvertimeDuration'] as String,
        overtimeNotes: json['OvertimeNotes'] as String,
        overtimeAttachments: (json['OvertimeAttachments'] as List<dynamic>)
            .map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        overtimeApprovers: (json['OvertimeApprovers'] as List<dynamic>)
            .map((e) => ApproverModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'OvertimeId': overtimeId,
        'OvertimeDocumentNumber': overtimeDocumentNumber,
        'OvertimeRequesterName': overtimeRequesterName,
        'OvertimeProfilePicture': overtimeProfilePicture,
        'OvertimeRequesterRole': overtimeRequesterRole,
        'OvertimeRequestDate': overtimeRequestDate,
        'OvertimeType': overtimeType,
        'OvertimeStatus': overtimeStatus,
        'OvertimeStartDate': overtimeStartDate,
        'OvertimeEndDate': overtimeEndDate,
        'OvertimeDuration': overtimeDuration,
        'OvertimeNotes': overtimeNotes,
        'OvertimeAttachments': overtimeAttachments,
        'OvertimeApprovers': overtimeApprovers,
      };
}
