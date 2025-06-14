import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:service_app/core/api_services/api-manager.dart';
import 'package:service_app/core/api_services/end_points.dart';
import 'package:service_app/core/failures/failures.dart';
import 'package:service_app/features/service/get_service/data/models/get_service_model.dart';
import 'package:service_app/features/service/get_service/data/models/service_details_model.dart';
import 'package:service_app/features/service/get_service/data/repo/get_service_repo.dart';

class GetServiceRepoImpl implements GetServiceRepo{
  ApiManager apiManager;

  GetServiceRepoImpl(this.apiManager);

  @override
  Future<Either<Failures, GetServiceModel>>? getService() async{
    try {
      Response response = await apiManager.getData(
        EndPoints.getServices,
        data: {},
      );
      GetServiceModel model = GetServiceModel.fromJson(response.data);
      print("Get Service Model data: ${response.data}");
      return Right(model);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.message ?? "failed to get Services"));
      } else {
        return left(ServerFailure("some thing went wrong"));
      }
    }
  }

  @override
  Future<Either<Failures, ServiceDetailsModel>>? getServiceDetails({required int serviceId}) async{
    try {
      Response response = await apiManager.getData(
        EndPoints.serviceDetails(serviceId),
        data: {},
      );
      ServiceDetailsModel model =ServiceDetailsModel.fromJson(response.data);
      print("Service Details data: ${response.data}");
      return Right(model);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.message ?? "failed to get Service Details"));
      } else {
        return left(ServerFailure("some thing went wrong"));
      }
    }
  }
}