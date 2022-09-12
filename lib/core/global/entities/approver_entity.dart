import 'package:equatable/equatable.dart';

class ApproverEntity extends Equatable {
  final String approverName;
  final String approverStatus;
  final String? approverDate;
  final String? rejectedReason;

  const ApproverEntity({
    required this.approverName,
    required this.approverStatus,
    this.approverDate,
    this.rejectedReason,
  });

  @override
  List<Object?> get props => [
        approverName,
        approverStatus,
        approverDate,
        rejectedReason,
      ];
}
