import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/overtime_detail_entity.dart';
import '../../domain/usecases/get_overtime_detail_usecase.dart';

part 'overtime_detail_event.dart';
part 'overtime_detail_state.dart';

class OvertimeDetailBloc
    extends Bloc<OvertimeDetailEvent, OvertimeDetailState> {
  final GetOvertimeDetailUsecase getOvertimeDetail;
  OvertimeDetailBloc({
    required this.getOvertimeDetail,
  }) : super(OvertimeDetailInitial()) {
    on<LoadOvertimeDetail>(_onLoadOvertimeDetail);
  }
  void _onLoadOvertimeDetail(
    LoadOvertimeDetail event,
    Emitter<OvertimeDetailState> emit,
  ) async {
    emit(OvertimeDetailLoading());
    try {
      final overtimeData = await getOvertimeDetail(event.overtimeId);
      overtimeData.fold(
        (l) {
          emit(OvertimeDetailLoadFailure(l));
        },
        (r) {
          emit(OvertimeListLoadSuccess(r));
        },
      );
    } catch (e) {
      emit(
        OvertimeDetailLoadFailure({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }
}
