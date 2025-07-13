class SendOtpModel {
  SendOtpModel({
      this.success, 
      this.userExists,});

  SendOtpModel.fromJson(dynamic json) {
    success = json['success'];
    userExists = json['user_exists'];
  }
  bool? success;
  bool? userExists;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['user_exists'] = userExists;
    return map;
  }
  @override
  String toString() {
    return 'SendOtpModel(success: $success, userExists: $userExists)';
  }
}