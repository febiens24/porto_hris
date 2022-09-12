import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/leave_entity.dart';
import '../../domain/usecases/approve_leave_request_usecase.dart';
import '../../domain/usecases/get_leave_approval_list.dart';
import '../../domain/usecases/reject_leave_request_usecase.dart';

part 'leave_approval_event.dart';
part 'leave_approval_state.dart';

class LeaveApprovalBloc extends Bloc<LeaveApprovalEvent, LeaveApprovalState> {
  final GetLeaveApprovalListUsecase getLeaveApprovalList;
  final ApproveLeaveRequestUsecase approveLeaveRequest;
  final RejectLeaveRequestUsecase rejectLeaveRequest;
  LeaveApprovalBloc({
    required this.getLeaveApprovalList,
    required this.approveLeaveRequest,
    required this.rejectLeaveRequest,
  }) : super(LeaveApprovalInitial()) {
    on<LeaveApprovalEvent>(_onLoadLeaveApprovalList);
    on<ApproveLeaveRequest>(_onApproveLeaveRequest);
    on<RejectLeaveRequest>(_onRejectLeaveRequest);
  }

  FutureOr<void> _onLoadLeaveApprovalList(
    LeaveApprovalEvent event,
    Emitter<LeaveApprovalState> emit,
  ) async {
    emit(LeaveApprovalLoading());
    try {
      final leaveData = await getLeaveApprovalList();
      leaveData.fold(
        (l) {
          emit(LeaveApprovalLoadFailure(l));
        },
        (r) {
          emit(LeaveApprovalLoadSuccess(r));
        },
      );
    } catch (e) {
      emit(
        LeaveApprovalLoadFailure({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }

  FutureOr<void> _onApproveLeaveRequest(
    ApproveLeaveRequest event,
    Emitter<LeaveApprovalState> emit,
  ) async {
    try {
      final leaveData = await approveLeaveRequest(
        event.leaveId,
      );
      leaveData.fold(
        (l) {
          emit(LeaveApprovalLoadFailure(l));
        },
        (r) {
          emit(LeaveApprovalLoadSuccess(r));
        },
      );
    } catch (e) {
      emit(
        LeaveApprovalLoadFailure({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }

  FutureOr<void> _onRejectLeaveRequest(
    RejectLeaveRequest event,
    Emitter<LeaveApprovalState> emit,
  ) async {
    try {
      final leaveData = await rejectLeaveRequest(
        event.leaveId,
        event.rejectReason,
      );
      leaveData.fold(
        (l) {
          emit(LeaveApprovalLoadFailure(l));
        },
        (r) {
          emit(LeaveApprovalLoadSuccess(r));
        },
      );
    } catch (e) {
      emit(
        LeaveApprovalLoadFailure({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }
}
