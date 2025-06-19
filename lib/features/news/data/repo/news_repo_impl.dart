import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:service_app/core/api_services/api-manager.dart';
import 'package:service_app/core/api_services/end_points.dart';
import 'package:service_app/core/failures/failures.dart';
import 'package:service_app/features/news/data/models/news_details_model.dart';
import 'package:service_app/features/news/data/models/news_model.dart';
import 'package:service_app/features/news/data/repo/news_repo.dart';


class NewsRepoImpl implements NewsRepo{
  ApiManager apiManager;

 NewsRepoImpl(this.apiManager);

  @override
  Future<Either<Failures, NewsModel>>? getNews() async{
    try {
      Response response = await apiManager.getData(
        EndPoints.getNews,
        data: {},
      );
      NewsModel model = NewsModel.fromJson(response.data);
      print("Get News Model data: ${response.data}");
      return Right(model);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.message ?? "failed to get News"));
      } else {
        return left(ServerFailure("some thing went wrong"));
      }
    }
  }

  @override
  Future<Either<Failures, NewsDetailsModel>>? getNewsDetails({required int newsId}) async{
    try {
      Response response = await apiManager.getData(
        EndPoints.newsDetails(newsId),
        data: {},
      );
      NewsDetailsModel model =NewsDetailsModel.fromJson(response.data);
      print("News Details Model data: ${response.data}");
      return Right(model);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(e.message ?? "failed to get News Details"));
      } else {
        return left(ServerFailure("some thing went wrong"));
      }
    }
  }
}