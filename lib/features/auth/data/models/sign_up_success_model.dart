class SignUpSuccessModel {
  SignUpSuccessModel({
      this.success, 
      this.userId, 
      this.userName, 
      this.phone, 
      this.nationalId,});

  SignUpSuccessModel.fromJson(dynamic json) {
    success = json['success'];
    userId = json['user_id'];
    userName = json['user_name'];
    phone = json['phone'];
    nationalId = json['national_id'];
  }
  bool? success;
  int? userId;
  String? userName;
  String? phone;
  String? nationalId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['user_id'] = userId;
    map['user_name'] = userName;
    map['phone'] = phone;
    map['national_id'] = nationalId;
    return map;
  }

}