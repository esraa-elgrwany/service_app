class VerifyOtpErrorModel {
  VerifyOtpErrorModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  VerifyOtpErrorModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result = json['result'] != null ? ErrorResult.fromJson(json['result']) : null;
  }
  String? jsonrpc;
  dynamic id;
  ErrorResult? result;

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

class ErrorResult {
  ErrorResult({
      this.success, 
      this.error,});

  ErrorResult.fromJson(dynamic json) {
    success = json['success'];
    error = json['error'];
  }
  bool? success;
  String? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['error'] = error;
    return map;
  }

}