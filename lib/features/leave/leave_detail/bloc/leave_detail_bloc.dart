import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/leave_detail_entity.dart';
import '../../domain/usecases/approve_leave_request_usecase.dart';
import '../../domain/usecases/get_leave_detail_usecase.dart';
import '../../domain/usecases/patch_leave_status_usecase.dart';
import '../../domain/usecases/reject_leave_request_usecase.dart';

part 'leave_detail_event.dart';
part 'leave_detail_state.dart';

class LeaveDetailBloc extends Bloc<LeaveDetailEvent, LeaveDetailState> {
  LeaveDetailBloc({
    required this.getLeaveDetailUsecase,
    required this.approveLeaveRequest,
    required this.rejectLeaveRequest,
    required this.patchLeaveStatus,
  }) : super(LeaveDetailInitial()) {
    on<LoadLeaveDetail>(_onLoadLeaveDetail);
    on<ApproveLeaveRequest>(_onApproveLeaveRequest);
    on<RejectLeaveRequest>(_onRejectLeaveRequest);
    on<PatchLeaveStatus>(_onPatchLeaveRequest);
  }

  final GetLeaveDetailUsecase getLeaveDetailUsecase;
  final ApproveLeaveRequestUsecase approveLeaveRequest;
  final RejectLeaveRequestUsecase rejectLeaveRequest;
  final PatchLeaveStatusUsecase patchLeaveStatus;

  void _onLoadLeaveDetail(
    LoadLeaveDetail event,
    Emitter<LeaveDetailState> emit,
  ) async {
    emit(LeaveDetailLoadInProgress());
    try {
      final leaveData = await getLeaveDetailUsecase(event.leaveId);
      leaveData.fold(
        (l) {
          emit(LeaveDetailLoadFailed(l));
        },
        (r) {
          emit(LeaveDetailLoadSuccess(r));
        },
      );
    } catch (e) {
      emit(
        LeaveDetailLoadFailed({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }

  FutureOr<void> _onApproveLeaveRequest(
    ApproveLeaveRequest event,
    Emitter<LeaveDetailState> emit,
  ) async {
    try {
      final leaveData = await approveLeaveRequest(
        event.leaveId,
      );
      leaveData.fold(
        (l) {
          emit(LeaveDetailLoadFailed(l));
        },
        (r) {
          emit(PatchLeaveSuccess(state.leaveDetail!));
        },
      );
    } catch (e) {
      emit(
        LeaveDetailLoadFailed({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }

  FutureOr<void> _onRejectLeaveRequest(
    RejectLeaveRequest event,
    Emitter<LeaveDetailState> emit,
  ) async {
    try {
      final leaveData = await rejectLeaveRequest(
        event.leaveId,
        event.rejectReason,
      );
      leaveData.fold(
        (l) {
          emit(LeaveDetailLoadFailed(l));
        },
        (r) {
          emit(PatchLeaveSuccess(state.leaveDetail!));
        },
      );
    } catch (e) {
      emit(
        LeaveDetailLoadFailed({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }

  FutureOr<void> _onPatchLeaveRequest(
    PatchLeaveStatus event,
    Emitter<LeaveDetailState> emit,
  ) {}
}
