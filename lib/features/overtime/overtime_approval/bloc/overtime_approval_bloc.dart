import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/overtime_entity.dart';
import '../../domain/usecases/get_overtime_approval_list_usecase.dart';

part 'overtime_approval_event.dart';
part 'overtime_approval_state.dart';

class OvertimeApprovalBloc
    extends Bloc<OvertimeApprovalEvent, OvertimeApprovalState> {
  final GetOvertimeApprovalListUsecase getOvertimeApprovalList;
  OvertimeApprovalBloc({
    required this.getOvertimeApprovalList,
  }) : super(OvertimeApprovalInitial()) {
    on<OvertimeApprovalEvent>(_onLoadOvertimeApprovalList);
  }

  FutureOr<void> _onLoadOvertimeApprovalList(
    OvertimeApprovalEvent event,
    Emitter<OvertimeApprovalState> emit,
  ) async {
    emit(OvertimeApprovalLoading());
    try {
      final overtimeData = await getOvertimeApprovalList();
      overtimeData.fold(
        (l) {
          emit(OvertimeApprovalLoadFailure(l));
        },
        (r) {
          emit(OvertimeApprovalLoadSuccess(r));
        },
      );
    } catch (e) {
      emit(
        OvertimeApprovalLoadFailure({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }
}
