part of 'dispensation_detail_bloc.dart';

abstract class DispensationDetailState extends Equatable {
  const DispensationDetailState();

  @override
  List<Object> get props => [];
}

class DispensationDetailInitial extends DispensationDetailState {}

class DispensationDetailLoading extends DispensationDetailState {}

class DispensationDetailLoadSuccess extends DispensationDetailState {
  final DispensationDetailEntity dispensationDetail;

  const DispensationDetailLoadSuccess(this.dispensationDetail);

  @override
  List<Object> get props => [dispensationDetail];
}

class DispensationDetailLoadFailure extends DispensationDetailState {
  final Map<String, dynamic> errors;

  const DispensationDetailLoadFailure(this.errors);

  @override
  List<Object> get props => [errors];
}
