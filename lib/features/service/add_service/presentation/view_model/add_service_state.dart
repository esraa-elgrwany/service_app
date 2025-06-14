part of 'add_service_cubit.dart';

@immutable
abstract class AddServiceState {}

class AddServiceInitial extends AddServiceState {}

//category
class GetCategoriesLoading extends AddServiceState {}

class GetCategoriesSuccess extends AddServiceState {
  CategoryModel model;
  GetCategoriesSuccess(this.model);
}

class GetCategoriesError extends AddServiceState {
  Failures failures;
  GetCategoriesError(this.failures);
}

//sub category
class GetSubCategoriesLoading extends AddServiceState {}

class GetSubCategoriesSuccess extends AddServiceState {
  SubCategoryModel model;
  GetSubCategoriesSuccess(this.model);
}

class GetSubCategoriesError extends AddServiceState {
  Failures failures;
  GetSubCategoriesError(this.failures);
}

//Service Type

class GetServiceTypeLoading extends AddServiceState {}

class GetServiceTypeSuccess extends AddServiceState {
  ServiceTypeModel model;
  GetServiceTypeSuccess(this.model);
}

class GetServiceTypeError extends AddServiceState {
  Failures failures;
  GetServiceTypeError(this.failures);
}

//Get Fields

class GetFieldsLoading extends AddServiceState {}

class GetFieldsSuccess extends AddServiceState {
  GetFieldsModel model;
  GetFieldsSuccess(this.model);
}

class GetFieldsError extends AddServiceState {
  Failures failures;
  GetFieldsError(this.failures);
}

//Get governments

class GetGovernmentsLoading extends AddServiceState {}

class GetGovernmentsSuccess extends AddServiceState {
  GovernmentModel model;
  GetGovernmentsSuccess(this.model);
}

class GetGovernmentsError extends AddServiceState {
  Failures failures;
  GetGovernmentsError(this.failures);
}

//Get States

class GetStatesLoading extends AddServiceState {}

class GetStatesSuccess extends AddServiceState {
  StatesModel model;
  GetStatesSuccess(this.model);
}

class GetStatesError extends AddServiceState {
  Failures failures;
  GetStatesError(this.failures);
}

//Get Village

class GetVillageLoading extends AddServiceState {}

class GetVillageSuccess extends AddServiceState {
  VillageModel model;
  GetVillageSuccess(this.model);
}

class GetVillageError extends AddServiceState {
  Failures failures;
  GetVillageError(this.failures);
}

//Get Document

class GetDocumentLoading extends AddServiceState {}

class GetDocumentSuccess extends AddServiceState {
  DocumentModel model;
  GetDocumentSuccess(this.model);
}

class GetDocumentError extends AddServiceState {
  Failures failures;
  GetDocumentError(this.failures);
}

//Get User

class GetUserLoading extends AddServiceState {}

class GetUserSuccess extends AddServiceState {
  UserModel model;
  GetUserSuccess(this.model);
}

class GetUserError extends AddServiceState {
  Failures failures;
  GetUserError(this.failures);
}

//Submit Service

class SubmitServiceLoading extends AddServiceState {}

class SubmitServiceSuccess extends AddServiceState {
  SubmitServiceModel model;
  SubmitServiceSuccess(this.model);
}

class SubmitServiceError extends AddServiceState {
  Failures failures;
  SubmitServiceError(this.failures);
}