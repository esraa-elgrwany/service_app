class VerifyOtpSuccessModel {
  VerifyOtpSuccessModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  VerifyOtpSuccessModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result = json['result'] != null ? SuccessResult.fromJson(json['result']) : null;
  }
  String? jsonrpc;
  dynamic id;
  SuccessResult? result;

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

class SuccessResult {
  SuccessResult({
      this.success, 
      this.action, 
      this.userId,});

  SuccessResult.fromJson(dynamic json) {
    success = json['success'];
    action = json['action'];
    userId = json['user_id'];
  }
  bool? success;
  String? action;
  int? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['action'] = action;
    map['user_id'] = userId;
    return map;
  }

}