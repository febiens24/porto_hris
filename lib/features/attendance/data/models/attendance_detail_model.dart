import '../../../../../core/global/entities/approver_entity.dart';
import '../../../../../core/global/entities/attachment_entity.dart';
import '../../../../core/global/models/approver_model.dart';
import '../../../../core/global/models/attachment_model.dart';
import '../../domain/entities/attendance_detail_entity.dart';

class AttendanceDetailModel extends AttendanceDetailEntity {
  const AttendanceDetailModel({
    required String status,
    required String message,
    required AttendanceDetailResultEntity result,
  }) : super(
          status: status,
          message: message,
          result: result,
        );

  factory AttendanceDetailModel.fromJson(Map<String, dynamic> json) =>
      AttendanceDetailModel(
        status: json['status'],
        message: json['message'],
        result: AttendanceDetailResultModel.fromJson(json['result']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result,
      };
}

class AttendanceDetailResultModel extends AttendanceDetailResultEntity {
  const AttendanceDetailResultModel({
    required int attendanceId,
    required String attendanceDocumentNumber,
    required String attendanceRequesterName,
    required String attendanceRequesterProfilePicture,
    required String attendanceRequesterRole,
    required String attendanceStatus,
    required String attendanceDateTime,
    required String attendanceType,
    required String attendanceMode,
    required String attendanceNotes,
    required String attendanceCoordinates,
    required List<AttachmentEntity> attendanceAttachments,
    required List<ApproverEntity> attendanceApprovers,
  }) : super(
          attendanceId: attendanceId,
          attendanceDocumentNumber: attendanceDocumentNumber,
          attendanceRequesterName: attendanceRequesterName,
          attendanceRequesterProfilePicture: attendanceRequesterProfilePicture,
          attendanceRequesterRole: attendanceRequesterRole,
          attendanceStatus: attendanceStatus,
          attendanceDateTime: attendanceDateTime,
          attendanceType: attendanceType,
          attendanceMode: attendanceMode,
          attendanceNotes: attendanceNotes,
          attendanceCoordinates: attendanceCoordinates,
          attendanceAttachments: attendanceAttachments,
          attendanceApprovers: attendanceApprovers,
        );

  factory AttendanceDetailResultModel.fromJson(Map<String, dynamic> json) =>
      AttendanceDetailResultModel(
        attendanceId: json['AttendanceId'] as int,
        attendanceDocumentNumber: json['AttendanceDocumentNumber'] as String,
        attendanceRequesterName: json['AttendanceRequesterName'] as String,
        attendanceRequesterProfilePicture:
            json['AttendanceRequesterProfilePicture'] as String,
        attendanceRequesterRole: json['AttendanceRequesterRole'] as String,
        attendanceStatus: json['AttendanceStatus'] as String,
        attendanceDateTime: json['AttendanceDateTime'] as String,
        attendanceType: json['AttendanceType'] as String,
        attendanceMode: json['AttendanceMode'] as String,
        attendanceNotes: json['AttendanceNotes'] as String,
        attendanceCoordinates: json['AttendanceCoordinates'] as String,
        attendanceAttachments: (json['AttendanceAttachments'] as List<dynamic>)
            .map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        attendanceApprovers: (json['AttendanceApprovers'] as List<dynamic>)
            .map((e) => ApproverModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'AttendanceId': attendanceId,
        'AttendanceDocumentNumber': attendanceDocumentNumber,
        'AttendanceRequesterName': attendanceRequesterName,
        'AttendanceRequesterProfilePicture': attendanceRequesterProfilePicture,
        'AttendanceRequesterRole': attendanceRequesterRole,
        'AttendanceStatus': attendanceStatus,
        'AttendanceDateTime': attendanceDateTime,
        'AttendanceNotes': attendanceNotes,
        'AttendanceCoordinates': attendanceCoordinates,
        'AttendanceAttachments': attendanceAttachments,
        'AttendanceApprovers': attendanceApprovers,
      };
}
