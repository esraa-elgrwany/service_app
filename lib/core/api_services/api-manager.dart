import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:service_app/core/utils/constants.dart';

class ApiManager {
  static final ApiManager _instance = ApiManager._internal();
  factory ApiManager() => _instance;

  late Dio dio;
  late CookieJar _cookieJar;

  ApiManager._internal();


  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    final cookiePath = "${dir.path}/.cookies/";

    _instance._cookieJar = PersistCookieJar(storage: FileStorage(cookiePath));

    _instance.dio = Dio(BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: {
        "Content-Type": "application/json",
      },
      validateStatus: (status) => status! < 500,
    ));

    _instance.dio.interceptors.add(CookieManager(_instance._cookieJar));
  }
  CookieJar get cookieJar => _cookieJar;

  Future<Response> getData(String endPoint, {Map<String, dynamic>? data}) {
    return dio.get(endPoint,data: data);
  }

  postData(String endPoint,{dynamic?body}) {
    return dio.post( endPoint,
        data: body,);
  }

  deleteData(String endPoint,{Map<String,dynamic>?body,}){
    return dio.delete(endPoint,
        data: body,);
  }

}

