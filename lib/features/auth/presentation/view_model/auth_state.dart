part of 'auth_cubit.dart';
@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

// send otp
class SendOtpLoading extends AuthState {}

class SendOtpSuccess extends AuthState {
  SendOtpModel model;
  SendOtpSuccess(this.model);
}

class SendOtpError extends AuthState {
  Failures failures;
  SendOtpError(this.failures);
}

//verify otp
class VerifyOtpLoading extends AuthState {}

class VerifyOtpSuccessState extends AuthState {
  final VerifyOtpSuccessModel model;
  VerifyOtpSuccessState(this.model);
}

class VerifyOtpErrorState extends AuthState {
  Failures failures;
  VerifyOtpErrorState(this.failures);
}


//register
class SignUpLoading extends AuthState {}

class SignUpSuccessState extends AuthState {
  final SignUpSuccessModel model;
  SignUpSuccessState(this.model);
}

class SignUpErrorState extends AuthState {
  Failures failures;
  SignUpErrorState(this.failures);
}