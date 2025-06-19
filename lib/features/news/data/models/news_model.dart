class NewsModel {
  NewsModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  NewsModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(NewsResult.fromJson(v));
      });
    }
  }
  String? jsonrpc;
  dynamic id;
  List<NewsResult>? result;

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

class NewsResult {
  NewsResult({
      this.id, 
      this.title, 
      this.author, 
      this.image, 
      this.date, 
      this.category,});

  NewsResult.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    image = json['image'];
    date = json['date'];
    category = json['category'];
  }
  int? id;
  String? title;
  String? author;
  String? image;
  String? date;
  String? category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['author'] = author;
    map['image'] = image;
    map['date'] = date;
    map['category'] = category;
    return map;
  }

}