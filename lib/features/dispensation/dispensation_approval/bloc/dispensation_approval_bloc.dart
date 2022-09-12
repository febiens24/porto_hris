import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/dispensation_entity.dart';
import '../../domain/usecases/get_dispensation_approval_usecase.dart';

part 'dispensation_approval_event.dart';
part 'dispensation_approval_state.dart';

class DispensationApprovalBloc
    extends Bloc<DispensationApprovalEvent, DispensationApprovalState> {
  final GetDispensationApprovalListUsecase getDispensationApprovalList;
  DispensationApprovalBloc({
    required this.getDispensationApprovalList,
  }) : super(DispensationApprovalInitial()) {
    on<DispensationApprovalEvent>(_onLoadDispensationApprovalList);
  }

  FutureOr<void> _onLoadDispensationApprovalList(
    DispensationApprovalEvent event,
    Emitter<DispensationApprovalState> emit,
  ) async {
    emit(DispensationApprovalLoading());
    try {
      final dispensationApprovalData = await getDispensationApprovalList();
      dispensationApprovalData.fold(
        (l) {
          emit(DispensationApprovalLoadFailure(l));
        },
        (r) {
          emit(DispensationApprovalLoadSuccess(r));
        },
      );
    } catch (e) {
      emit(
        DispensationApprovalLoadFailure({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }
}
