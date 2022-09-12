import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/reprimand_entity.dart';
import '../../domain/usecases/get_reprimand_approval_list_usecase.dart';

part 'reprimand_approval_event.dart';
part 'reprimand_approval_state.dart';

class ReprimandApprovalBloc
    extends Bloc<ReprimandApprovalEvent, ReprimandApprovalState> {
  final GetReprimandApprovalListUsecase getReprimandApprovalList;
  ReprimandApprovalBloc({
    required this.getReprimandApprovalList,
  }) : super(ReprimandApprovalInitial()) {
    on<ReprimandApprovalEvent>(_onLoadReprimandApprovalList);
  }

  FutureOr<void> _onLoadReprimandApprovalList(
    ReprimandApprovalEvent event,
    Emitter<ReprimandApprovalState> emit,
  ) async {
    emit(ReprimandApprovalLoading());
    try {
      final reprimandApprovals = await getReprimandApprovalList();
      reprimandApprovals.fold(
        (l) {
          emit(ReprimandApprovalLoadFailure(l));
        },
        (r) {
          emit(ReprimandApprovalLoadSuccess(r));
        },
      );
    } catch (e) {
      emit(
        ReprimandApprovalLoadFailure({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }
}
