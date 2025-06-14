class UserModel {
  UserModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  UserModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? jsonrpc;
  dynamic id;
  Result? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['jsonrpc'] = jsonrpc;
    map['id'] = id;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }

}

class Result {
  Result({
      this.success, 
      this.user,});

  Result.fromJson(dynamic json) {
    success = json['success'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  bool? success;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

class User {
  User({
      this.userId, 
      this.userName, 
      this.partnerId, 
      this.partnerName, 
      this.nationalId, 
      this.phone,});

  User.fromJson(dynamic json) {
    userId = json['user_id'];
    userName = json['user_name'];
    partnerId = json['partner_id'];
    partnerName = json['partner_name'];
    nationalId = json['national_id'];
    phone = json['phone'];
  }
  int? userId;
  String? userName;
  int? partnerId;
  String? partnerName;
  String? nationalId;
  String? phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['user_name'] = userName;
    map['partner_id'] = partnerId;
    map['partner_name'] = partnerName;
    map['national_id'] = nationalId;
    map['phone'] = phone;
    return map;
  }

}