import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:service_app/core/api_services/api-manager.dart';
import 'package:service_app/core/failures/failures.dart';
import 'package:service_app/features/service/get_service/data/models/get_service_model.dart';
import 'package:service_app/features/service/get_service/data/models/service_details_model.dart';
import 'package:service_app/features/service/get_service/data/repo/get_service_repo.dart';
import 'package:service_app/features/service/get_service/data/repo/get_service_repo_impl.dart';

part 'get_service_state.dart';

class GetServiceCubit extends Cubit<GetServiceState> {
  List<Services> services=[];
  List<Service> serviceDetails=[];
  static GetServiceCubit get(context) => BlocProvider.of(context);
  GetServiceCubit() : super(GetServiceInitial());

  void getServices() async{
    emit(GetServiceLoading());
    ApiManager apiManager=ApiManager();
    GetServiceRepo addServiceRepo =GetServiceRepoImpl(apiManager);
    var res=await addServiceRepo.getService();
    res?.fold((l) {
      print("Service error++++++++++++++++++++++++++************************+${l.errorMsg}");
      emit(GetServiceError(l));
    }, (r) {
      emit(GetServiceSuccess(r));
      services=r.result?.services??[];
      print("Service success++++++++++++++++++++++++++************************+${r.result}");
    });
  }
}
