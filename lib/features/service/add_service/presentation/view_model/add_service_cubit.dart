import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:service_app/core/failures/failures.dart';
import 'package:service_app/features/service/add_service/data/models/document_model.dart';
import 'package:service_app/features/service/add_service/data/models/get_fields_model.dart';
import 'package:service_app/features/service/add_service/data/models/government_model.dart';
import 'package:service_app/features/service/add_service/data/models/service_type_model.dart';
import 'package:service_app/features/service/add_service/data/models/states_model.dart';
import 'package:service_app/features/service/add_service/data/models/sub_category_model.dart';
import 'package:service_app/features/service/add_service/data/models/submit_service_model.dart';
import 'package:service_app/features/service/add_service/data/models/village_model.dart';
import 'package:service_app/features/service/add_service/data/repo/add_service_repo_impl.dart';
import '../../../../../core/api_services/api-manager.dart';
import '../../data/models/category_model.dart';
import '../../data/repo/add_service_repo.dart';

part 'add_service_state.dart';

class AddServiceCubit extends Cubit<AddServiceState> {
  List<CategoryResult> categories=[];
  List<SubCategoryResult> subCategories=[];
  List<ServiceTypeResult> serviceTypeList=[];
  List<Fields> fields=[];
  List<GovernmentResult> governments=[];
  List<StatesResult> states=[];
  List<VillageResult> village=[];
  List<DocumentTypes> document=[];
  static AddServiceCubit get(context) => BlocProvider.of(context);
  AddServiceCubit() : super(AddServiceInitial());

  void getCategories() async{
    emit(GetCategoriesLoading());
    ApiManager apiManager=ApiManager();
    AddServiceRepo addServiceRepo =AddServiceRepoImpl(apiManager);
    var res=await addServiceRepo.getCategory();
    res?.fold((l) {
      print("category error++++++++++++++++++++++++++************************+${l.errorMsg}");
      emit(GetCategoriesError(l));
    }, (r) {
      emit(GetCategoriesSuccess(r));
      categories=r.result??[];
      print("category success++++++++++++++++++++++++++************************+${r.result}");
    });
  }

  void getSubCategories({required int catId}) async{
    emit(GetSubCategoriesLoading());
    ApiManager apiManager=ApiManager();
    AddServiceRepo addServiceRepo =AddServiceRepoImpl(apiManager);
    var res=await addServiceRepo.getSubCategory(categoryId: catId);
    res?.fold((l) {
      print("Sub category error++++++++++++++++++++++++++************************+${l.errorMsg}");
      emit(GetSubCategoriesError(l));
    }, (r) {
      emit(GetSubCategoriesSuccess(r));
      subCategories=r.result??[];
      print("Sub category success++++++++++++++++++++++++++************************+${r.result}");
    });
  }

  void getServiceType({required int subCatId}) async{
    emit(GetServiceTypeLoading());
    ApiManager apiManager=ApiManager();
    AddServiceRepo addServiceRepo =AddServiceRepoImpl(apiManager);
    var res=await addServiceRepo.getServiceType(subCategoryId: subCatId);
    res?.fold((l) {
      print("Service Type error++++++++++++++++++++++++++************************+${l.errorMsg}");
      emit(GetServiceTypeError(l));
    }, (r) {
      emit(GetServiceTypeSuccess(r));
      serviceTypeList=r.result??[];
      print("Service Type success++++++++++++++++++++++++++************************+${r.result}");
    });
  }

  void getFields({required int serviceId}) async{
    emit(GetFieldsLoading());
    ApiManager apiManager=ApiManager();
    AddServiceRepo addServiceRepo =AddServiceRepoImpl(apiManager);
    var res=await addServiceRepo.getFields(serviceTypeId: serviceId);
    res?.fold((l) {
      print("Fields error++++++++++++++++++++++++++************************+${l.errorMsg}");
      emit(GetFieldsError(l));
    }, (r) {
      emit(GetFieldsSuccess(r));
      fields=r.result?.fields??[];
      print("Fields success++++++++++++++++++++++++++************************+${r.result}");
    });
  }

  void getGovernments() async{
    emit(GetGovernmentsLoading());
    ApiManager apiManager=ApiManager();
    AddServiceRepo addServiceRepo =AddServiceRepoImpl(apiManager);
    var res=await addServiceRepo.getGovernments();
    res?.fold((l) {
      print("Governments error++++++++++++++++++++++++++************************+${l.errorMsg}");
      emit(GetGovernmentsError(l));
    }, (r) {
      emit(GetGovernmentsSuccess(r));
      governments=r.result??[];
      print("Governments success++++++++++++++++++++++++++************************+${r.result}");
    });
  }

  void getStates({required int governId}) async{
    emit(GetStatesLoading());
    ApiManager apiManager=ApiManager();
    AddServiceRepo addServiceRepo =AddServiceRepoImpl(apiManager);
    var res=await addServiceRepo.getStates(
      governmentId: governId
    );
    res?.fold((l) {
      print("States error++++++++++++++++++++++++++************************+${l.errorMsg}");
      emit(GetStatesError(l));
    }, (r) {
      emit(GetStatesSuccess(r));
      states=r.result??[];
      print("States success++++++++++++++++++++++++++************************+${r.result}");
    });
  }

  void getVillage({required int stateId}) async{
    emit(GetVillageLoading());
    ApiManager apiManager=ApiManager();
    AddServiceRepo addServiceRepo =AddServiceRepoImpl(apiManager);
    var res=await addServiceRepo.getVillages(
        stateId: stateId
    );
    res?.fold((l) {
      print("Village error++++++++++++++++++++++++++************************+${l.errorMsg}");
      emit(GetVillageError(l));
    }, (r) {
      emit(GetVillageSuccess(r));
      village=r.result??[];
      print("Village success++++++++++++++++++++++++++************************+${r.result}");
    });
  }

  void getDocument({required int serviceId}) async{
    emit(GetDocumentLoading());
    ApiManager apiManager=ApiManager();
    AddServiceRepo addServiceRepo =AddServiceRepoImpl(apiManager);
    var res=await addServiceRepo.getDocument(serviceTypeId: serviceId);
    res?.fold((l) {
      print("Document error++++++++++++++++++++++++++************************+${l.errorMsg}");
      emit(GetDocumentError(l));
    }, (r) {
      emit(GetDocumentSuccess(r));
      document=r.result?.documentTypes??[];
      print("Document success++++++++++++++++++++++++++************************+${r.result}");
    });
  }

  void submitService({
    required int categoryId,
    required int subCategoryId,
    required int serviceTypeId,
    required String description,
    required Map<String, dynamic> fieldsData,
    //List<File>? files
  }) async{
    emit(SubmitServiceLoading());
    ApiManager apiManager=ApiManager();
    AddServiceRepo addServiceRepo =AddServiceRepoImpl(apiManager);
    var res=await addServiceRepo. submitService(categoryId:categoryId ,subCategoryId: subCategoryId,serviceTypeId: serviceTypeId
    ,description: description,fieldsData: fieldsData//files: files
    );
    res?.fold((l) {
      print("submit Service error++++++++++++++++++++++++++************************+${l.errorMsg}");
      emit(SubmitServiceError(l));
    }, (r) {
      emit(SubmitServiceSuccess(r));
      print("submit Service success++++++++++++++++++++++++++************************+${r.message}");
    });
  }
}
