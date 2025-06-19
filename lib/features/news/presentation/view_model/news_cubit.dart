import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:service_app/core/api_services/api-manager.dart';
import 'package:service_app/core/failures/failures.dart';
import 'package:service_app/features/news/data/models/news_details_model.dart';
import 'package:service_app/features/news/data/models/news_model.dart';
import 'package:service_app/features/news/data/repo/news_repo.dart';
import 'package:service_app/features/news/data/repo/news_repo_impl.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  List<NewsResult> news=[];
  NewsDetailsResult? newsDetails;

  static NewsCubit get(context) => BlocProvider.of(context);

  NewsCubit() : super(NewsInitial());

  void getNews() async{
    emit(GetNewsLoading());
    ApiManager apiManager=ApiManager();
    NewsRepo newsRepo =NewsRepoImpl(apiManager);
    var res=await newsRepo.getNews();
    res?.fold((l) {
      print("News error++++++++++++++++++++++++++************************+${l.errorMsg}");
      emit(GetNewsError(l));
    }, (r) {
      emit(GetNewsSuccess(r));
      news=r.result??[];
      print("News success++++++++++++++++++++++++++************************+${r.result}");
    });
  }

  void getNewsDetails({required int newsId}) async{
    emit(GetNewsDetailsLoading());
    ApiManager apiManager=ApiManager();
    NewsRepo newsRepo =NewsRepoImpl(apiManager);
    var res=await newsRepo.getNewsDetails(newsId: newsId);
    res?.fold((l) {
      print("News Details error++++++++++++++++++++++++++************************+${l.errorMsg}");
      emit(GetNewsDetailsError(l));
    }, (r) {
      emit(GetNewsDetailsSuccess(r));
      newsDetails = r.result;
      print("News Details success++++++++++++++++++++++++++************************+${r.result}");
    });
  }
}
