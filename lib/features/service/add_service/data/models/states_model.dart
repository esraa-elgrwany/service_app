class StatesModel {
  StatesModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  StatesModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(StatesResult.fromJson(v));
      });
    }
  }
  String? jsonrpc;
  dynamic id;
  List<StatesResult>? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['jsonrpc'] = jsonrpc;
    map['id'] = id;
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class StatesResult {
  StatesResult({
      this.id, 
      this.stateName, 
      this.stateCode,});

  StatesResult.fromJson(dynamic json) {
    id = json['id'];
    stateName = json['state_name'];
    stateCode = json['state_code'];
  }
  int? id;
  String? stateName;
  String? stateCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['state_name'] = stateName;
    map['state_code'] = stateCode;
    return map;
  }

}