import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/dispensation_detail_entity.dart';
import '../../domain/usecases/get_dispensation_detail_usecase.dart';

part 'dispensation_detail_event.dart';
part 'dispensation_detail_state.dart';

class DispensationDetailBloc
    extends Bloc<DispensationDetailEvent, DispensationDetailState> {
  final GetDispensationDetailUsecase getDispensationDetail;
  DispensationDetailBloc({
    required this.getDispensationDetail,
  }) : super(DispensationDetailInitial()) {
    on<LoadDispensationDetail>(_onLoadDispensationDetail);
  }

  void _onLoadDispensationDetail(
    LoadDispensationDetail event,
    Emitter<DispensationDetailState> emit,
  ) async {
    emit(DispensationDetailLoading());
    try {
      final dispensationList =
          await getDispensationDetail(event.dispensationId);
      dispensationList.fold(
        (l) {
          print(l);
          emit(DispensationDetailLoadFailure(l));
        },
        (r) {
          print(r);
          emit(DispensationDetailLoadSuccess(r));
        },
      );
    } catch (e) {
      print(e);
      emit(
        DispensationDetailLoadFailure({
          "status": 'error',
          "result": e.toString(),
        }),
      );
    }
  }
}
