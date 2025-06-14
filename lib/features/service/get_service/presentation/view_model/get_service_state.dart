part of 'get_service_cubit.dart';

@immutable
abstract class GetServiceState {}

class GetServiceInitial extends GetServiceState {}
class GetServiceLoading extends GetServiceState {}

class GetServiceSuccess extends GetServiceState{
  GetServiceModel model;
  GetServiceSuccess(this.model);
}

class GetServiceError extends GetServiceState{
  Failures failures;

  GetServiceError(this.failures);
}


class GetServiceDetailsLoading extends GetServiceState {}

class GetServiceDetailsSuccess extends GetServiceState{
  ServiceDetailsModel model;
  GetServiceDetailsSuccess(this.model);
}

class GetServiceDetailsError extends GetServiceState{
  Failures failures;

  GetServiceDetailsError(this.failures);
}
