import '../../../../../core/global/entities/approver_entity.dart';
import '../../../../../core/global/entities/attachment_entity.dart';
import '../../../../../core/global/models/approver_model.dart';
import '../../../../../core/global/models/attachment_model.dart';
import '../../domain/entities/business_trip_detail_entity.dart';

class BusinessTripDetailModel extends BusinessTripDetailEntity {
  const BusinessTripDetailModel({
    required String status,
    required String message,
    required BusinessTripDetailResultEntity result,
  }) : super(
          status: status,
          message: message,
          result: result,
        );

  factory BusinessTripDetailModel.fromJson(Map<String, dynamic> json) =>
      BusinessTripDetailModel(
        status: json['status'],
        message: json['message'],
        result: BusinessTripDetailResultModel.fromJson(json['result']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result,
      };
}

class BusinessTripDetailResultModel extends BusinessTripDetailResultEntity {
  const BusinessTripDetailResultModel({
    required int businessTripId,
    required String businessTripDocumentNumber,
    required String businessTripRequesterName,
    required String businessTripProfilePicture,
    required String businessTripRequesterRole,
    required String businessTripStatus,
    required String businessTripRequestedDate,
    required String businessTripType,
    required String businessTripStartDate,
    required String businessTripEndDate,
    required String businessTripDuration,
    required String businessTripLocation,
    required String businessTripNotes,
    required List<AttachmentEntity> businessTripAttachments,
    required List<ApproverEntity> businessTripApprovers,
  }) : super(
          businessTripId: businessTripId,
          businessTripDocumentNumber: businessTripDocumentNumber,
          businessTripRequesterName: businessTripRequesterName,
          businessTripProfilePicture: businessTripProfilePicture,
          businessTripRequesterRole: businessTripRequesterRole,
          businessTripStatus: businessTripStatus,
          businessTripRequestedDate: businessTripRequestedDate,
          businessTripType: businessTripType,
          businessTripStartDate: businessTripStartDate,
          businessTripEndDate: businessTripEndDate,
          businessTripDuration: businessTripDuration,
          businessTripLocation: businessTripLocation,
          businessTripNotes: businessTripNotes,
          businessTripAttachments: businessTripAttachments,
          businessTripApprovers: businessTripApprovers,
        );

  factory BusinessTripDetailResultModel.fromJson(Map<String, dynamic> json) =>
      BusinessTripDetailResultModel(
        businessTripId: json["BusinessTripId"] as int,
        businessTripDocumentNumber:
            json["BusinessTripDocumentNumber"] as String,
        businessTripRequesterName: json["BusinessTripRequesterName"] as String,
        businessTripProfilePicture:
            json["BusinessTripProfilePicture"] as String,
        businessTripRequesterRole: json["BusinessTripRequesterRole"] as String,
        businessTripStatus: json["BusinessTripStatus"] as String,
        businessTripRequestedDate: json["BusinessTripRequestedDate"] as String,
        businessTripType: json["BusinessTripType"] as String,
        businessTripStartDate: json["BusinessTripStartDate"] as String,
        businessTripEndDate: json["BusinessTripEndDate"] as String,
        businessTripDuration: json["BusinessTripDuration"] as String,
        businessTripLocation: json["BusinessTripLocation"] as String,
        businessTripNotes: json["BusinessTripNotes"] as String,
        businessTripAttachments:
            (json['BusinessTripAttachments'] as List<dynamic>)
                .map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
                .toList(),
        businessTripApprovers: (json['BusinessTripApprovers'] as List<dynamic>)
            .map((e) => ApproverModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'BusinessTripId': businessTripId,
        'BusinessTripDocumentNumber': businessTripDocumentNumber,
        'BusinessTripRequesterName': businessTripRequesterName,
        'BusinessTripProfilePicture': businessTripProfilePicture,
        'BusinessTripRequesterRole': businessTripRequesterRole,
        'BusinessTripStatus': businessTripStatus,
        'BusinessTripRequestedDate': businessTripRequestedDate,
        'BusinessTripType': businessTripType,
        'BusinessTripStartDate': businessTripStartDate,
        'BusinessTripEndDate': businessTripEndDate,
        'BusinessTripDuration': businessTripDuration,
        'BusinessTripLocation': businessTripLocation,
        'BusinessTripNotes': businessTripNotes,
        'BusinessTripAttachments': businessTripAttachments,
        'BusinessTripApprovers': businessTripApprovers,
      };
}
