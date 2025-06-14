import 'package:dartz/dartz.dart';
import 'package:service_app/core/failures/failures.dart';
import 'package:service_app/features/auth/data/models/send_otp_model.dart';

abstract class AuthRepo{
  Future<Either<Failures,SendOtpModel>>? sendOtp({required String phone});
  Future<Either<Failures,dynamic>>? verifyOtp({ required String phone,required String otp});
  Future<Either<Failures,dynamic>>? register({ required String phone,required String name,required String id,required String expiryDate,
    required String address});
}