import 'package:dartz/dartz.dart';
import 'package:service_app/core/failures/failures.dart';
import 'package:service_app/features/auth/data/models/send_otp_model.dart';
import 'package:service_app/features/auth/data/models/sign_up_success_model.dart';
import 'package:service_app/features/auth/data/models/verify_otp_success_model.dart';



abstract class AuthRepo{
  Future<Either<Failures,SendOtpModel>>? sendOtp({required String phone});
  Future<Either<Failures,VerifyOtpSuccessModel>>? verifyOtp({ required String phone,required String otp});
  Future<Either<Failures,SignUpSuccessModel>>? register({ required String phone,required String name,required String id,required String expiryDate,
    required String address});
}