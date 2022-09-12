import 'package:dartz/dartz.dart';

import '../entities/business_trip_entity.dart';
import '../repositories/business_trip_repository.dart';

class PatchBusinessTripStatusUsecase {
  final BusinessTripRepository businessTripRepository;

  PatchBusinessTripStatusUsecase(this.businessTripRepository);

  Future<Either<Map<String, dynamic>, BusinessTripEntity>> call(
    int businessTripId,
    String state,
    String? cancelReason,
  ) async {
    return await businessTripRepository.patchBusinessTripStatus(
      businessTripId,
      state,
      cancelReason,
    );
  }
}
