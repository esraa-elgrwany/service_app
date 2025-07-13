import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:service_app/core/api_services/api-manager.dart';
import 'package:service_app/core/failures/failures.dart';
import 'package:service_app/features/auth/data/models/send_otp_model.dart';
import 'package:service_app/features/auth/data/models/sign_up_success_model.dart';
import 'package:service_app/features/auth/data/models/verify_otp_success_model.dart';
import 'package:service_app/features/auth/data/repo/auth_repo.dart';
import 'package:service_app/features/auth/data/repo/auth_repo_impl.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  static AuthCubit get(context) => BlocProvider.of(context);

  AuthCubit() : super(AuthInitial());

  void sendOtp({required String phone}) async {
    emit(SendOtpLoading());
    ApiManager apiManager = ApiManager();
    AuthRepo authRepo = AuthRepoImpl(apiManager);
    var res = await authRepo.sendOtp(phone: phone);
    res?.fold((l) {
      print("++++++++++++++++++++++++++************************+${l.errorMsg}");
      emit(SendOtpError(l));
    }, (r) {
      emit(SendOtpSuccess(r));
      print("++++++++++++++++++++++++++************************+${r}");
    });
  }

  void verifyOtp({
    required String phone,
    required String otp,
  }) async {
    emit(VerifyOtpLoading());
    ApiManager apiManager = ApiManager();
    AuthRepo authRepo = AuthRepoImpl(apiManager);
    var res = await authRepo.verifyOtp(phone: phone, otp: otp);
    res?.fold(
      (failure) {
        print("verify failure c++++++++++++++++++++++++++************************+${failure.errorMsg}");
        emit(VerifyOtpErrorState(failure));
      },
      (data) {
        emit(VerifyOtpSuccessState(data));
        print("verify success c ++++++++++++++++++++++++++************************+${data}");
      },
    );
  }

  //register
  void register({
    required String phone,
    required String name,
    required String nationalId,
    required String nationalIdExpiry,
    required String address,
  }) async {
    emit(SignUpLoading());

    ApiManager apiManager = ApiManager();
    AuthRepo authRepo = AuthRepoImpl(apiManager);

    final result = await authRepo.register(
      phone: phone,
      name: name,
      id: nationalId,
      expiryDate: nationalIdExpiry,
      address: address,
    );

    result?.fold(
      (failure) {
        emit(SignUpErrorState(failure));
      },
      (data) {
          emit(SignUpSuccessState(data));
      },
    );
  }
}
