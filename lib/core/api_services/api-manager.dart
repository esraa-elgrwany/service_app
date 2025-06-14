import 'package:dio/dio.dart';
import 'package:service_app/core/utils/constants.dart';

class ApiManager {
  Dio dio = Dio();

  Future<Response> getData(String endPoint, {Map<String, dynamic>? data}) {
    return dio.get(Constants.baseUrl + endPoint,data: data);
  }

  postData(String endPoint,{Map<String,dynamic>?body}) {
    return dio.post(Constants.baseUrl + endPoint,
        data: body,);
  }

  deleteData(String endPoint,{Map<String,dynamic>?body,}){
    return dio.delete(Constants.baseUrl + endPoint,
        data: body,);
  }

}

