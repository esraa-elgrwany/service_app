import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:service_app/core/api_services/api-manager.dart';
import 'package:service_app/core/failures/failures.dart';
import 'package:service_app/core/utils/constants.dart';
import 'package:service_app/features/service/add_service/data/models/category_model.dart';
import 'package:service_app/features/service/add_service/data/models/document_model.dart';
import 'package:service_app/features/service/add_service/data/models/get_fields_model.dart';
import 'package:service_app/features/service/add_service/data/models/government_model.dart';
import 'package:service_app/features/service/add_service/data/models/service_type_model.dart';
import 'package:service_app/features/service/add_service/data/models/states_model.dart';
import 'package:service_app/features/service/add_service/data/models/sub_category_model.dart';
import 'package:service_app/features/service/add_service/data/models/submit_service_model.dart';
import 'package:service_app/features/service/add_service/data/models/user_model.dart';
import 'package:service_app/features/service/add_service/data/models/village_model.dart';
import 'package:service_app/features/service/add_service/data/repo/add_service_repo.dart';

import '../../../../../core/api_services/end_points.dart';

class AddServiceRepoImpl implements AddServiceRepo{
  ApiManager apiManager;

  AddServiceRepoImpl(this.apiManager);

  @override
  Future<Either<Failures, CategoryModel>>? getCategory() async{
    try {
      Response response = await apiManager.getData(
        EndPoints.getCategories,
        data: {},
      );
      CategoryModel model = CategoryModel.fromJson(response.data);
      print("Category Model data: ${response.data}");
      return Right(model);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.message ?? "failed to get categories"));
      } else {
        return left(ServerFailure("some thing went wrong"));
      }
    }
  }

  @override
  Future<Either<Failures, ServiceTypeModel>>? getServiceType({required int subCategoryId}) async{
    try {
      Response response = await apiManager.getData(
        EndPoints.serviceType(subCategoryId),
        data: {},
      );
      ServiceTypeModel model = ServiceTypeModel.fromJson(response.data);
      print("Service Type data: ${response.data}");
      return Right(model);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.message ?? "failed to get Service Type"));
      } else {
        return left(ServerFailure("some thing went wrong"));
      }
    }
  }

  @override
  Future<Either<Failures, SubCategoryModel>>? getSubCategory({required int categoryId}) async{
    try {
      Response response = await apiManager.getData(
        EndPoints.subCategories(categoryId),
        data: {},
      );
      SubCategoryModel model = SubCategoryModel.fromJson(response.data);
      print("Sub Category data: ${response.data}");
      return Right(model);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.message ?? "failed to get Sub Category"));
      } else {
        return left(ServerFailure("some thing went wrong"));
      }
    }
  }

  @override
  Future<Either<Failures, GetFieldsModel>>? getFields({required int serviceTypeId}) async{
    try {
      Response response = await apiManager.getData(
        EndPoints.getFields(serviceTypeId),
        data: {},
      );
      GetFieldsModel model = GetFieldsModel.fromJson(response.data);
      print("Get Fields data: ${response.data}");
      return Right(model);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.message ?? "failed to get Get Fields"));
      } else {
        return left(ServerFailure("some thing went wrong"));
      }
    }
  }

  @override
  Future<Either<Failures, DocumentModel>>? getDocument({required int serviceTypeId}) async{
    try {
      Response response = await apiManager.getData(
        EndPoints.getDocuments(serviceTypeId),
        data: {},
      );
      DocumentModel model = DocumentModel.fromJson(response.data);
      print("Documents data: ${response.data}");
      return Right(model);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.message ?? "failed to get Documents"));
      } else {
        return left(ServerFailure("some thing went wrong"));
      }
    }
  }

  @override
  Future<Either<Failures, GovernmentModel>>? getGovernments() async{
    try {
      Response response = await apiManager.getData(
        EndPoints.getGovern,
        data: {},
      );
      GovernmentModel model = GovernmentModel.fromJson(response.data);
      print("Government data: ${response.data}");
      return Right(model);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.message ?? "failed to get Government"));
      } else {
        return left(ServerFailure("some thing went wrong"));
      }
    }
  }

  @override
  Future<Either<Failures, StatesModel>>? getStates({required int governmentId}) async{
    try {
      Response response = await apiManager.getData(
        EndPoints.getStates(governmentId),
        data: {},
      );
      StatesModel model = StatesModel.fromJson(response.data);
      print("States data: ${response.data}");
      return Right(model);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.message ?? "failed to get States"));
      } else {
        return left(ServerFailure("some thing went wrong"));
      }
    }
  }

  @override
  Future<Either<Failures, VillageModel>>? getVillages({required int stateId}) async{
    try {
      Response response = await apiManager.getData(
        EndPoints.getVillage(stateId),
        data: {},
      );
      VillageModel model = VillageModel.fromJson(response.data);
      print("Village data: ${response.data}");
      return Right(model);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.message ?? "failed to get Village"));
      } else {
        return left(ServerFailure("some thing went wrong"));
      }
    }
  }

  @override
  Future<Either<Failures, UserModel>>? getUser() async{
    try {
      Response response = await apiManager.getData(
        EndPoints.getUser,
        data: {},
      );
      UserModel model = UserModel.fromJson(response.data);
      print("User Model data: ${response.data}");
      return Right(model);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.message ?? "failed to get User data"));
      } else {
        return left(ServerFailure("some thing went wrong"));
      }
    }
  }

  @override
  Future<Either<Failures, SubmitServiceModel>>? submitService({required int categoryId, required int subCategoryId,
    required int serviceTypeId, required String description, required Map<String, dynamic> fieldsData})async {
    final dio = Dio();

    try {
      final payload = {
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "service_type_id": serviceTypeId,
        "description": description,
        "fields_data": fieldsData,
      };

      final formData = FormData.fromMap({
        "payload_json": jsonEncode(payload),
      });

      final response = await dio.post(
        Constants.baseUrl + EndPoints.createServices,
        data: formData,
      );
      SubmitServiceModel model = SubmitServiceModel.fromJson(response.data);
      print("Submit Service data: ${response.data}");
      return Right(model);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.message ?? "failed to Submit Service"));
      } else {
        return left(ServerFailure("some thing went wrong"));
      }
    }
  }

}