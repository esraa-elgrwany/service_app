class SendOtpModel {
  SendOtpModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  SendOtpModel.fromJson(dynamic json) {
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
      this.userExists,});

  Result.fromJson(dynamic json) {
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

}