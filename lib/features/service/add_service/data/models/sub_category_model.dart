class SubCategoryModel {
  SubCategoryModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  SubCategoryModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(SubCategoryResult.fromJson(v));
      });
    }
  }
  String? jsonrpc;
  dynamic id;
  List<SubCategoryResult>? result;

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

class SubCategoryResult {
  SubCategoryResult({
      this.id, 
      this.name,});

  SubCategoryResult.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}