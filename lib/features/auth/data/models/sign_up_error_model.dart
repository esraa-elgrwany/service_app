class SignUpErrorModel {
  SignUpErrorModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  SignUpErrorModel.fromJson(dynamic json) {
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
      this.error,});

  Result.fromJson(dynamic json) {
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