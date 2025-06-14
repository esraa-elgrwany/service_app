class DocumentModel {
  DocumentModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  DocumentModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result = json['result'] != null ? DocumentResult.fromJson(json['result']) : null;
  }
  String? jsonrpc;
  dynamic id;
  DocumentResult? result;

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

class DocumentResult {
  DocumentResult({
      this.success, 
      this.serviceTypeId, 
      this.documentTypeCount, 
      this.documentTypes,});

  DocumentResult.fromJson(dynamic json) {
    success = json['success'];
    serviceTypeId = json['service_type_id'];
    documentTypeCount = json['document_type_count'];
    if (json['document_types'] != null) {
      documentTypes = [];
      json['document_types'].forEach((v) {
        documentTypes?.add(DocumentTypes.fromJson(v));
      });
    }
  }
  bool? success;
  int? serviceTypeId;
  int? documentTypeCount;
  List<DocumentTypes>? documentTypes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['service_type_id'] = serviceTypeId;
    map['document_type_count'] = documentTypeCount;
    if (documentTypes != null) {
      map['document_types'] = documentTypes?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class DocumentTypes {
  DocumentTypes({
      this.id, 
      this.name,});

  DocumentTypes.fromJson(dynamic json) {
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