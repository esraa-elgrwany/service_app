class NewsDetailsModel {
  NewsDetailsModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  NewsDetailsModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result = json['result'] != null ? NewsDetailsResult.fromJson(json['result']) : null;
  }
  String? jsonrpc;
  dynamic id;
  NewsDetailsResult? result;

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

class NewsDetailsResult {
  NewsDetailsResult({
      this.id, 
      this.title, 
      this.content, 
      this.category, 
      this.image, 
      this.url,});

  NewsDetailsResult.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    category = json['category'];
    image = json['image'];
    url = json['url'];
  }
  int? id;
  String? title;
  String? content;
  String? category;
  String? image;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['content'] = content;
    map['category'] = category;
    map['image'] = image;
    map['url'] = url;
    return map;
  }

}