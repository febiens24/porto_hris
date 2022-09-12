part of 'reprimand_detail_bloc.dart';

abstract class ReprimandDetailState extends Equatable {
  const ReprimandDetailState();

  @override
  List<Object> get props => [];
}

class ReprimandDetailInitial extends ReprimandDetailState {}

class ReprimandDetailLoading extends ReprimandDetailState {}

class ReprimandDetailLoadSuccess extends ReprimandDetailState {
  final ReprimandDetailEntity reprimandDetail;

  const ReprimandDetailLoadSuccess(this.reprimandDetail);

  @override
  List<Object> get props => [reprimandDetail];
}

class ReprimandDetailLoadFailure extends ReprimandDetailState {
  final Map<String, dynamic> errors;

  const ReprimandDetailLoadFailure(this.errors);

  @override
  List<Object> get props => [errors];
}
