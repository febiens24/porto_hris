import 'package:dartz/dartz.dart';

import '../entities/business_trip_entity.dart';
import '../repositories/business_trip_repository.dart';

class RejectBusinessTripRequestUsecase {
  final BusinessTripRepository businessTripRepository;

  RejectBusinessTripRequestUsecase(this.businessTripRepository);

  Future<Either<Map<String, dynamic>, BusinessTripEntity>> call(
    int businessTripId,
    String rejectReason,
  ) async {
    return await businessTripRepository.rejectBusinessTripRequest(
      businessTripId,
      rejectReason,
    );
  }
}
