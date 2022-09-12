import 'package:dartz/dartz.dart';

import '../entities/business_trip_detail_entity.dart';
import '../entities/business_trip_entity.dart';

abstract class BusinessTripRepository {
  Future<Either<Map<String, dynamic>, BusinessTripEntity>> getBusinessTripList({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  });

  Future<Either<Map<String, dynamic>, BusinessTripDetailEntity>>
      getBusinessTripDetail(
    int businessTripId,
  );

  Future<Either<Map<String, dynamic>, BusinessTripEntity>>
      getBusinessTripApprovalList();

  Future<Either<Map<String, dynamic>, BusinessTripEntity>>
      getBusinessTripApprovalHistoryList({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  });

  Future<Either<Map<String, dynamic>, BusinessTripEntity>>
      patchBusinessTripStatus(
    int businessTripId,
    String state,
    String? cancelReason,
  );

  Future<Either<Map<String, dynamic>, BusinessTripEntity>>
      approveBusinessTripRequest(
    int businessTripId,
  );

  Future<Either<Map<String, dynamic>, BusinessTripEntity>>
      rejectBusinessTripRequest(
    int businessTripId,
    String rejectReason,
  );
}
