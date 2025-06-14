class VerifyOtpSignupModel {
  VerifyOtpSignupModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  VerifyOtpSignupModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result = json['result'] != null ? SignUpResult.fromJson(json['result']) : null;
  }
  String? jsonrpc;
  dynamic id;
  SignUpResult? result;

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

class SignUpResult {
  SignUpResult({
      this.success, 
      this.action, 
      this.phone,});

  SignUpResult.fromJson(dynamic json) {
    success = json['success'];
    action = json['action'];
    phone = json['phone'];
  }
  bool? success;
  String? action;
  String? phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['action'] = action;
    map['phone'] = phone;
    return map;
  }

}