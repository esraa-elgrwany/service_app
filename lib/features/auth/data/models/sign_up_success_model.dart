class SignUpSuccessModel {
  SignUpSuccessModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  SignUpSuccessModel.fromJson(dynamic json) {
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
      this.userId,});

  Result.fromJson(dynamic json) {
    success = json['success'];
    userId = json['user_id'];
  }
  bool? success;
  int? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['user_id'] = userId;
    return map;
  }

}