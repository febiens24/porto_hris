import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/attendance_entity.dart';

part 'attendance_model.g.dart';

class AttendanceModel extends AttendanceEntity {
  const AttendanceModel({
    required String status,
    required String message,
    List<AttendanceResultEntity>? result,
  }) : super(
          status: status,
          message: message,
          result: result,
        );

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
        status: json['status'],
        message: json['message'],
        result: (json['result'] as List<dynamic>?)
            ?.map((e) =>
                AttendanceResultModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result,
      };
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class AttendanceResultModel extends AttendanceResultEntity {
  const AttendanceResultModel({
    required int attendanceId,
    required String attendanceDocumentNumber,
    String? attendanceRequesterName,
    String? attendanceRequesterProfilePicture,
    String? attendanceRequesterRole,
    required String attendanceStatus,
    required String attendanceDateTime,
    required String attendanceType,
    required String attendanceMode,
    required String attendanceNotes,
    // List<AttachmentEntity>? attendanceAttachments,
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
          // attendanceAttachments: attendanceAttachments,
        );

  factory AttendanceResultModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceResultModelToJson(this);
}
