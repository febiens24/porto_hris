import '../entities/attachment_entity.dart';

class AttachmentModel extends AttachmentEntity {
  const AttachmentModel({
    required String attachmentLink,
    required String attachmentName,
  }) : super(
          attachmentLink: attachmentLink,
          attachmentName: attachmentName,
        );

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      AttachmentModel(
        attachmentLink: json['AttachmentLink'] as String,
        attachmentName: json['AttachmentName'] as String,
      );

  Map<String, dynamic> toJson() => {
        'AttachmentLink': attachmentLink,
        'AttachmentName': attachmentName,
      };
}
