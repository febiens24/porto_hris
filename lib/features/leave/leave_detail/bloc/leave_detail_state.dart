part of 'leave_detail_bloc.dart';

abstract class LeaveDetailState extends Equatable {
  final LeaveDetailEntity? leaveDetail;
  const LeaveDetailState({this.leaveDetail});

  @override
  List<Object> get props => [];
}

class LeaveDetailInitial extends LeaveDetailState {}

class LeaveDetailLoadSuccess extends LeaveDetailState {
  final LeaveDetailEntity leaveDetailEntity;

  const LeaveDetailLoadSuccess(this.leaveDetailEntity)
      : super(leaveDetail: leaveDetailEntity);

  @override
  List<Object> get props => [leaveDetailEntity];
}

class LeaveDetailLoadFailed extends LeaveDetailState {
  final Map<String, dynamic> errorMsg;

  const LeaveDetailLoadFailed(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}

class LeaveDetailLoadInProgress extends LeaveDetailState {}

class PatchLeaveSuccess extends LeaveDetailState {
  final LeaveDetailEntity leaveDetailEntity;

  const PatchLeaveSuccess(this.leaveDetailEntity)
      : super(leaveDetail: leaveDetailEntity);

  @override
  List<Object> get props => [leaveDetailEntity];
}
