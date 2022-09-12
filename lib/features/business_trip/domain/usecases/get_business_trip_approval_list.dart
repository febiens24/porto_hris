import 'package:dartz/dartz.dart';

import '../entities/business_trip_entity.dart';
import '../repositories/business_trip_repository.dart';

class GetBusinessTripApprovalListUsecase {
  final BusinessTripRepository businessTripRepository;

  GetBusinessTripApprovalListUsecase(this.businessTripRepository);

  Future<Either<Map<String, dynamic>, BusinessTripEntity>> call() async {
    return await businessTripRepository.getBusinessTripApprovalList();
  }
}
