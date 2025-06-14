class GetFieldsModel {
  GetFieldsModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  GetFieldsModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result = json['result'] != null ? GetFieldsResult.fromJson(json['result']) : null;
  }
  String? jsonrpc;
  dynamic id;
  GetFieldsResult? result;

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

class GetFieldsResult {
  GetFieldsResult({
      this.serviceTypeId, 
      this.fields,});

  GetFieldsResult.fromJson(dynamic json) {
    serviceTypeId = json['service_type_id'];
    if (json['fields'] != null) {
      fields = [];
      json['fields'].forEach((v) {
        fields?.add(Fields.fromJson(v));
      });
    }
  }
  int? serviceTypeId;
  List<Fields>? fields;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_type_id'] = serviceTypeId;
    if (fields != null) {
      map['fields'] = fields?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Fields {
  Fields({
      this.name, 
      this.label, 
      this.type, 
      this.required, 
      this.optional, 
      this.no,
    this.status,});

  Fields.fromJson(dynamic json) {
    name = json['name'];
    label = json['label'];
    type = json['type'];
    required = json['required'];
    optional = json['optional'];
    no = json['no'];
    status = json['status'];
  }
  String? name;
  String? label;
  String? type;
  bool? required;
  bool? optional;
  bool? no;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['label'] = label;
    map['type'] = type;
    map['required'] = required;
    map['optional'] = optional;
    map['no'] = no;
    map['status'] = status;
    return map;
  }

}