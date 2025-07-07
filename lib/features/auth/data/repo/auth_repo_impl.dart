import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:service_app/core/api_services/api-manager.dart';
import 'package:service_app/core/api_services/end_points.dart';
import 'package:service_app/core/failures/failures.dart';
import 'package:service_app/features/auth/data/models/send_otp_model.dart';
import 'package:service_app/features/auth/data/models/sign_up_success_model.dart';
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
  Future<Either<Failures,VerifyOtpSuccessModel>> verifyOtp(
      {required String phone,required String otp}) async {
    try {
      final response = await apiManager.postData(
        EndPoints.verifyOtp,
        body: {"phone": phone, "otp": otp},
      );
      VerifyOtpSuccessModel model = VerifyOtpSuccessModel.fromJson(response.data);
      print("Response Data: ${response.data}");
      return Right(model);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.message ?? "Failed to send OTP"));
      } else {
        return left(ServerFailure("Something went wrong"));
      }
    }

  }

  @override
  Future<Either<Failures,SignUpSuccessModel>>? register({required String phone, required String name, required String id,
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
      SignUpSuccessModel model =SignUpSuccessModel.fromJson(response.data);
      print("Response Data: ${response.data}");
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
    }

  }
