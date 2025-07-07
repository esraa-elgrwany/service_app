import 'dart:io';

import 'package:dartz/dartz.dart';
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
import '../../../../../core/failures/failures.dart';

abstract class AddServiceRepo{
  Future<Either<Failures,CategoryModel>>? getCategory();
  Future<Either<Failures,SubCategoryModel>>? getSubCategory({ required int categoryId});
  Future<Either<Failures,ServiceTypeModel>>? getServiceType({ required int subCategoryId});
  Future<Either<Failures,GetFieldsModel>>? getFields({ required int serviceTypeId});
  Future<Either<Failures,GovernmentModel>>? getGovernments();
  Future<Either<Failures,StatesModel>>? getStates({ required int governmentId});
  Future<Either<Failures,VillageModel>>? getVillages({ required int stateId});
  Future<Either<Failures,DocumentModel>>? getDocument({ required int serviceTypeId});
  Future<Either<Failures,SubmitServiceModel>>? submitService({
    required int categoryId,
    required int subCategoryId,
    required int serviceTypeId,
    required String description,
    required Map<String, dynamic> fieldsData,
    //List<File>? files,
  });
}