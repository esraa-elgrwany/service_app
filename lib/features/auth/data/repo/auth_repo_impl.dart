import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:service_app/core/api_services/api-manager.dart';
import 'package:service_app/core/api_services/end_points.dart';
import 'package:service_app/core/failures/failures.dart';
import 'package:service_app/features/auth/data/models/send_otp_model.dart';
import 'package:service_app/features/auth/data/models/sign_up_error_model.dart';
import 'package:service_app/features/auth/data/models/sign_up_success_model.dart';
import 'package:service_app/features/auth/data/models/verify_otp_error_model.dart';
import 'package:service_app/features/auth/data/models/verify_otp_signup_model.dart';
import 'package:service_app/features/auth/data/models/verify_otp_success_model.dart';
import 'package:service_app/features/auth/data/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  ApiManager apiManager;

  AuthRepoImpl(this.apiManager);

  @override
  Future<Either<Failures, SendOtpModel>>? sendOtp({required String phone}) async {
    try {
      Response response = await apiManager.postData(
        EndPoints.sendOtp,
        body: {"phone": phone},
      );
      SendOtpModel model = SendOtpModel.fromJson(response.data);
      print("Response Data: ${response.data}");
      return Right(model);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.message ?? "failed to send OTP"));
      } else {
        return left(ServerFailure("some thing went wrong"));
      }
    }
  }

  @override
  Future<Either<Failures, dynamic>> verifyOtp(
      {required String phone,required String otp}) async {
    try {
      final response = await apiManager.postData(
        EndPoints.verifyOtp,
        body: {"phone": phone, "otp": otp},
      );
      final result = response.data['result'];

      if (result['success'] == true && result['action'] == 'login') {
        return Right(VerifyOtpSuccessModel.fromJson(response.data));
      } else if (result['success'] == false && result['action'] == 'signup_required') {
        return Right(VerifyOtpSignupModel.fromJson(response.data));
      } else if (result['success'] == false && result['error'] != null) {
        return Right(VerifyOtpErrorModel.fromJson(response.data));
      } else {
        return left(ServerFailure('Unexpected response format'));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.message ?? "Failed to send OTP"));
      } else {
        return left(ServerFailure("Something went wrong"));
      }
    }
  }

  @override
  Future<Either<Failures,dynamic>>? register({required String phone, required String name, required String id,
    required String expiryDate, required String address}) async{
    try {
      final response = await apiManager.postData(
        EndPoints.signUp,
        body: {"phone": phone,
          "name": name,
          "national_id": id,
          "national_id_expiry": expiryDate,
          "address": address
        },
      );
      final data = response.data;
     print("++++++signup data$data");
      if (data['result'] != null && data['result']['success'] == true) {
        return Right(SignUpSuccessModel.fromJson(data));
      } else if (data['result'] != null && data['result']['success'] == false && data['result']['error'] != null) {
        return Right(SignUpErrorModel.fromJson(data));
      } else {
        return Left(ServerFailure("Unexpected response format"));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
    }
  }
