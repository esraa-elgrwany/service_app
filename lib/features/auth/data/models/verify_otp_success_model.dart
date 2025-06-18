class VerifyOtpSuccessModel {
  VerifyOtpSuccessModel({
      this.success, 
      this.action, 
      this.userId, 
      this.userName, 
      this.phone, 
      this.nationalId,});

  VerifyOtpSuccessModel.fromJson(dynamic json) {
    success = json['success'];
    action = json['action'];
    userId = json['user_id'];
    userName = json['user_name'];
    phone = json['phone'];
    nationalId = json['national_id'];
  }
  bool? success;
  String? action;
  int? userId;
  String? userName;
  String? phone;
  String? nationalId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['action'] = action;
    map['user_id'] = userId;
    map['user_name'] = userName;
    map['phone'] = phone;
    map['national_id'] = nationalId;
    return map;
  }

}