import 'package:equatable/equatable.dart';

class AttachmentEntity extends Equatable {
  final String attachmentLink;
  final String attachmentName;

  const AttachmentEntity({
    required this.attachmentLink,
    required this.attachmentName,
  });

  @override
  List<Object?> get props => [
        attachmentLink,
        attachmentName,
      ];
}
