import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../models/news_details_model.dart';
import '../models/news_model.dart';

abstract class NewsRepo {
  Future<Either<Failures,NewsModel>>? getNews();

  Future<Either<Failures, NewsDetailsModel>>? getNewsDetails(
      {required int newsId});
}