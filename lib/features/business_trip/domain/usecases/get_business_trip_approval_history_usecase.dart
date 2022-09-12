import 'package:dartz/dartz.dart';

import '../entities/business_trip_entity.dart';
import '../repositories/business_trip_repository.dart';

class GetBusinessTripApprovalHistoryListUsecase {
  final BusinessTripRepository businessTripRepository;

  GetBusinessTripApprovalHistoryListUsecase(this.businessTripRepository);

  Future<Either<Map<String, dynamic>, BusinessTripEntity>> call({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  }) async {
    return await businessTripRepository.getBusinessTripApprovalHistoryList(
      status: status,
      type: type,
      dateFrom: dateFrom,
      dateTo: dateTo,
      q: q,
      page: page,
    );
  }
}
