class SubmitServiceModel {
  SubmitServiceModel({
      this.success, 
      this.serviceId, 
      this.message, 
      });

  SubmitServiceModel.fromJson(dynamic json) {
    success = json['success'];
    serviceId = json['service_id'];
    message = json['message'];
  }
  bool? success;
  int? serviceId;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['service_id'] = serviceId;
    map['message'] = message;
    return map;
  }

}