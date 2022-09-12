import '../entities/approver_entity.dart';

class ApproverModel extends ApproverEntity {
  const ApproverModel({
    required String approverName,
    required String approverStatus,
    String? approverDate,
    String? rejectedReason,
  }) : super(
          approverName: approverName,
          approverStatus: approverStatus,
          approverDate: approverDate,
          rejectedReason: rejectedReason,
        );

  factory ApproverModel.fromJson(Map<String, dynamic> json) => ApproverModel(
        approverName: json["ApproverName"] as String,
        approverStatus: json["ApproverStatus"] as String,
        approverDate: json["ApproverDate"] as String?,
        rejectedReason: json["ApproverReason"] as String?,
      );

  Map<String, dynamic> toJson() => {
        'ApproverName': approverName,
        'ApproverStatus': approverStatus,
        'ApproverDate': approverDate,
        'ApproverReason': approverStatus,
      };
}
