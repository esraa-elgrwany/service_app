import 'package:dartz/dartz.dart';
import 'package:service_app/core/failures/failures.dart';
import 'package:service_app/features/service/get_service/data/models/get_service_model.dart';
import 'package:service_app/features/service/get_service/data/models/service_details_model.dart';

abstract class GetServiceRepo {
  Future<Either<Failures, GetServiceModel>>? getService();

  Future<Either<Failures, ServiceDetailsModel>>? getServiceDetails(
      {required int serviceId});
}
