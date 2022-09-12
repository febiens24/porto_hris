import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/reprimand_detail_entity.dart';
import '../../domain/usecases/get_reprimand_detail_usecase.dart';

part 'reprimand_detail_event.dart';
part 'reprimand_detail_state.dart';

class ReprimandDetailBloc
    extends Bloc<ReprimandDetailEvent, ReprimandDetailState> {
  final GetReprimandDetailUsecase getReprimandDetail;
  ReprimandDetailBloc({
    required this.getReprimandDetail,
  }) : super(ReprimandDetailInitial()) {
    on<LoadReprimandDetail>(_onLoadReprimandDetail);
  }

  FutureOr<void> _onLoadReprimandDetail(
    LoadReprimandDetail event,
    Emitter<ReprimandDetailState> emit,
  ) async {
    emit(ReprimandDetailLoading());
    try {
      final reprimandData = await getReprimandDetail(event.reprimandId);
      reprimandData.fold(
        (l) {
          emit(ReprimandDetailLoadFailure(l));
        },
        (r) {
          emit(ReprimandDetailLoadSuccess(r));
        },
      );
    } catch (e) {
      emit(
        ReprimandDetailLoadFailure({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }
}
