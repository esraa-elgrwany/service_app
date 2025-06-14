class GetServiceModel {
  GetServiceModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  GetServiceModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result = json['result'] != null ? ServiceResult.fromJson(json['result']) : null;
  }
  String? jsonrpc;
  dynamic id;
  ServiceResult? result;

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

class ServiceResult {
  ServiceResult({
      this.success, 
      this.services,});

  ServiceResult.fromJson(dynamic json) {
    success = json['success'];
    if (json['services'] != null) {
      services = [];
      json['services'].forEach((v) {
        services?.add(Services.fromJson(v));
      });
    }
  }
  bool? success;
  List<Services>? services;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (services != null) {
      map['services'] = services?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Services {
  Services({
      this.id, 
      this.reference, 
      this.name, 
      this.date, 
      this.category, 
      this.subCategory, 
      this.serviceType, 
      this.stage,});

  Services.fromJson(dynamic json) {
    id = json['id'];
    reference = json['reference'];
    name = json['name'];
    date = json['date'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    subCategory = json['sub_category'] != null ? SubCategory.fromJson(json['sub_category']) : null;
    serviceType = json['service_type'] != null ? ServiceType.fromJson(json['service_type']) : null;
    stage = json['stage'] != null ? Stage.fromJson(json['stage']) : null;
  }
  int? id;
  String? reference;
  String? name;
  String? date;
  Category? category;
  SubCategory? subCategory;
  ServiceType? serviceType;
  Stage? stage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['reference'] = reference;
    map['name'] = name;
    map['date'] = date;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    if (subCategory != null) {
      map['sub_category'] = subCategory?.toJson();
    }
    if (serviceType != null) {
      map['service_type'] = serviceType?.toJson();
    }
    if (stage != null) {
      map['stage'] = stage?.toJson();
    }
    return map;
  }

}

class Stage {
  Stage({
      this.id, 
      this.name,});

  Stage.fromJson(dynamic json) {
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

class ServiceType {
  ServiceType({
      this.id, 
      this.name,});

  ServiceType.fromJson(dynamic json) {
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

class SubCategory {
  SubCategory({
      this.id, 
      this.name,});

  SubCategory.fromJson(dynamic json) {
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

class Category {
  Category({
      this.id, 
      this.name,});

  Category.fromJson(dynamic json) {
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