import 'package:dartz/dartz.dart';

import '../entities/business_trip_detail_entity.dart';
import '../repositories/business_trip_repository.dart';

class GetBusinessTripDetailUsecase {
  final BusinessTripRepository businessTripRepository;

  GetBusinessTripDetailUsecase(this.businessTripRepository);

  Future<Either<Map<String, dynamic>, BusinessTripDetailEntity>> call(
    int businessTripId,
  ) async {
    return await businessTripRepository.getBusinessTripDetail(businessTripId);
  }
}
