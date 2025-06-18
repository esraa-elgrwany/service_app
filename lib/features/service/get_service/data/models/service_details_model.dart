class ServiceDetailsModel {
  ServiceDetailsModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  ServiceDetailsModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result = json['result'] != null ? ServiceDetailsResult.fromJson(json['result']) : null;
  }
  String? jsonrpc;
  dynamic id;
  ServiceDetailsResult? result;

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

class ServiceDetailsResult {
  ServiceDetailsResult({
      this.success, 
      this.service,});

  ServiceDetailsResult.fromJson(dynamic json) {
    success = json['success'];
    service = json['service'] != null ? Service.fromJson(json['service']) : null;
  }
  bool? success;
  Service? service;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (service != null) {
      map['service'] = service?.toJson();
    }
    return map;
  }

}

class Service {
  Service({
      this.id, 
      this.reference, 
      this.name, 
      this.date, 
      this.phone, 
      this.location, 
      this.nationalId, 
      this.fromDate, 
      this.toDate, 
      this.state, 
      this.government, 
      this.village, 
      this.category, 
      this.subCategory, 
      this.serviceType, 
      this.serviceTypeId, 
      this.stage, 
      this.partner,
      this.fieldsConfig,});

  Service.fromJson(dynamic json) {
    id = json['id'];
    reference = json['reference'];
    name = json['name'];
    date = json['date'];
    phone = json['phone'];
    location = json['location'];
    nationalId = json['national_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    state = json['state'];
    government = json['government'];
    village = json['village'];
    category = json['category'];
    subCategory = json['sub_category'];
    serviceType = json['service_type'];
    serviceTypeId = json['service_type_id'];
    stage = json['stage'];
    partner = json['partner'];
    if (json['fields_config'] != null) {
      fieldsConfig = [];
      json['fields_config'].forEach((v) {
        fieldsConfig?.add(FieldsConfig.fromJson(v));
      });
    }
  }
  int? id;
  String? reference;
  String? name;
  String? date;
  String? phone;
  String? location;
  String? nationalId;
  String? fromDate;
  String? toDate;
  String? state;
  String? government;
  String? village;
  String? category;
  String? subCategory;
  String? serviceType;
  int? serviceTypeId;
  String? stage;
  String? partner;
  List<FieldsConfig>? fieldsConfig;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['reference'] = reference;
    map['name'] = name;
    map['date'] = date;
    map['phone'] = phone;
    map['location'] = location;
    map['national_id'] = nationalId;
    map['from_date'] = fromDate;
    map['to_date'] = toDate;
    map['state'] = state;
    map['government'] = government;
    map['village'] = village;
    map['category'] = category;
    map['sub_category'] = subCategory;
    map['service_type'] = serviceType;
    map['service_type_id'] = serviceTypeId;
    map['stage'] = stage;
    map['partner'] = partner;
    if (fieldsConfig != null) {
      map['fields_config'] = fieldsConfig?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class FieldsConfig {
  FieldsConfig({
      this.name, 
      this.label, 
      this.type, 
      this.required, 
      this.optional, 
      this.no, 
      this.status, 
      this.relation,});

  FieldsConfig.fromJson(dynamic json) {
    name = json['name'];
    label = json['label'];
    type = json['type'];
    required = json['required'];
    optional = json['optional'];
    no = json['no'];
    status = json['status'];
    relation = json['relation'];
  }
  String? name;
  String? label;
  String? type;
  bool? required;
  bool? optional;
  bool? no;
  String? status;
  String? relation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['label'] = label;
    map['type'] = type;
    map['required'] = required;
    map['optional'] = optional;
    map['no'] = no;
    map['status'] = status;
    map['relation'] = relation;
    return map;
  }

}