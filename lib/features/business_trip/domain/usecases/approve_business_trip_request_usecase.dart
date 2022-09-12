import 'package:dartz/dartz.dart';

import '../entities/business_trip_entity.dart';
import '../repositories/business_trip_repository.dart';

class ApproveBusinessTripRequestUsecase {
  final BusinessTripRepository businessTripRepository;

  ApproveBusinessTripRequestUsecase(this.businessTripRepository);

  Future<Either<Map<String, dynamic>, BusinessTripEntity>> call(
    int businessTripId,
  ) async {
    return await businessTripRepository.approveBusinessTripRequest(
      businessTripId,
    );
  }
}
