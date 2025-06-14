class VillageModel {
  VillageModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  VillageModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(VillageResult.fromJson(v));
      });
    }
  }
  String? jsonrpc;
  dynamic id;
  List<VillageResult>? result;

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

class VillageResult {
  VillageResult({
      this.id, 
      this.villageName, 
      this.villageCode,});

  VillageResult.fromJson(dynamic json) {
    id = json['id'];
    villageName = json['village_name'];
    villageCode = json['village_code'];
  }
  int? id;
  String? villageName;
  String? villageCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['village_name'] = villageName;
    map['village_code'] = villageCode;
    return map;
  }

}