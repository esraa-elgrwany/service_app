class GovernmentModel {
  GovernmentModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  GovernmentModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(GovernmentResult.fromJson(v));
      });
    }
  }
  String? jsonrpc;
  dynamic id;
  List<GovernmentResult>? result;

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

class GovernmentResult {
  GovernmentResult({
      this.id, 
      this.governmentName, 
      this.countryId,});

  GovernmentResult.fromJson(dynamic json) {
    id = json['id'];
    governmentName = json['government_name'];
    countryId = json['country_id'];
  }
  int? id;
  String? governmentName;
  int? countryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['government_name'] = governmentName;
    map['country_id'] = countryId;
    return map;
  }

}