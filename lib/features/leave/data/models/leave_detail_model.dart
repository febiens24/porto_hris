import '../../../../../core/global/models/approver_model.dart';
import '../../../../../core/global/models/attachment_model.dart';
import '../../domain/entities/leave_detail_entity.dart';

class LeaveDetailModel extends LeaveDetailEntity {
  const LeaveDetailModel({
    required String status,
    required String message,
    required LeaveDetailResultEntity result,
  }) : super(
          status: status,
          message: message,
          result: result,
        );

  factory LeaveDetailModel.fromJson(Map<String, dynamic> json) =>
      LeaveDetailModel(
        status: json['status'],
        message: json['message'],
        result: LeaveDetailResultModel.fromJson(json['result']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result,
      };
}

class LeaveDetailResultModel extends LeaveDetailResultEntity {
  const LeaveDetailResultModel({
    required int leaveId,
    required String leaveDocumentNumber,
    required String leaveRequesterName,
    required String leaveRequesterProfilePicture,
    required String leaveRequesterRole,
    required String leaveStatus,
    required String leaveRequestDate,
    required String leaveType,
    required String leaveDateFrom,
    required String leaveDateTo,
    required String leaveDuration,
    required String leaveNotes,
    required List<AttachmentModel> leaveAttachment,
    required List<ApproverModel> leaveApprover,
  }) : super(
          leaveId: leaveId,
          leaveDocumentNumber: leaveDocumentNumber,
          leaveRequesterName: leaveRequesterName,
          leaveRequesterProfilePicture: leaveRequesterProfilePicture,
          leaveRequesterRole: leaveRequesterRole,
          leaveStatus: leaveStatus,
          leaveRequestDate: leaveRequestDate,
          leaveType: leaveType,
          leaveDateFrom: leaveDateFrom,
          leaveDateTo: leaveDateTo,
          leaveDuration: leaveDuration,
          leaveNotes: leaveNotes,
          leaveAttachment: leaveAttachment,
          leaveApprover: leaveApprover,
        );

  factory LeaveDetailResultModel.fromJson(Map<String, dynamic> json) =>
      LeaveDetailResultModel(
        leaveType: json["LeaveType"] as String,
        leaveStatus: json["LeaveStatus"] as String,
        leaveRequestDate: json["LeaveRequestDate"] as String,
        leaveNotes: json["LeaveNotes"] as String,
        leaveId: json["LeaveId"] as int,
        leaveDocumentNumber: json["LeaveDocumentNumber"] as String,
        leaveRequesterName: json["LeaveRequesterName"] as String,
        leaveRequesterProfilePicture:
            json["LeaveRequesterProfilePicture"] as String,
        leaveRequesterRole: json["LeaveRequesterRole"] as String,
        leaveDateTo: json["LeaveDateTo"] as String,
        leaveDateFrom: json["LeaveDateFrom"] as String,
        leaveDuration: json["LeaveDuration"] as String,
        leaveAttachment: (json['LeaveAttachments'] as List<dynamic>)
            .map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        leaveApprover: (json['LeaveApprovers'] as List<dynamic>)
            .map((e) => ApproverModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'LeaveType': leaveType,
        'LeaveStatus': leaveStatus,
        'LeaveRequestDate': leaveRequestDate,
        'LeaveNotes': leaveNotes,
        'LeaveId': leaveId,
        'LeaveDocumentNumber': leaveDocumentNumber,
        'LeaveRequesterName': leaveRequesterName,
        'LeaveRequesterProfilePicture': leaveRequesterProfilePicture,
        'LeaveRequesterRole': leaveRequesterRole,
        'LeaveDateTo': leaveDateTo,
        'LeaveDateFrom': leaveDateFrom,
        'LeaveDuration': leaveDuration,
        'LeaveAttachments': leaveAttachment,
        'LeaveApprovers': leaveApprover,
      };
}
