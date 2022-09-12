import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/swap_workdate_entity.dart';
import '../../domain/usecases/get_swap_workdate_approval_list_usecase.dart';

part 'swap_workdate_approval_event.dart';
part 'swap_workdate_approval_state.dart';

class SwapWorkdateApprovalBloc
    extends Bloc<SwapWorkdateApprovalEvent, SwapWorkdateApprovalState> {
  final GetSwapWorkdateApprovalListUsecase getSwapWorkdateApprovalList;
  SwapWorkdateApprovalBloc({
    required this.getSwapWorkdateApprovalList,
  }) : super(SwapWorkdateApprovalInitial()) {
    on<SwapWorkdateApprovalEvent>(_onLoadReprimandApprovalList);
  }

  FutureOr<void> _onLoadReprimandApprovalList(
    SwapWorkdateApprovalEvent event,
    Emitter<SwapWorkdateApprovalState> emit,
  ) async {
    emit(SwapWorkdateApprovalLoading());
    try {
      final reprimandApprovals = await getSwapWorkdateApprovalList();
      reprimandApprovals.fold(
        (l) {
          emit(SwapWorkdateApprovalLoadFailure(l));
        },
        (r) {
          emit(SwapWorkdateApprovalLoadSuccess(r));
        },
      );
    } catch (e) {
      emit(
        SwapWorkdateApprovalLoadFailure({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }
}
