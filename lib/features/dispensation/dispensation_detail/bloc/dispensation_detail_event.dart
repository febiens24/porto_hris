part of 'dispensation_detail_bloc.dart';

abstract class DispensationDetailEvent extends Equatable {
  const DispensationDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadDispensationDetail extends DispensationDetailEvent {
  final int dispensationId;

  const LoadDispensationDetail(this.dispensationId);

  @override
  List<Object> get props => [dispensationId];
}
