part of 'news_cubit.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}

class GetNewsLoading extends NewsState {}

class GetNewsSuccess extends NewsState{
  NewsModel model;
  GetNewsSuccess(this.model);
}

class GetNewsError extends NewsState{
  Failures failures;

  GetNewsError(this.failures);
}

class GetNewsDetailsLoading extends NewsState {}

class GetNewsDetailsSuccess extends NewsState{
  NewsDetailsModel model;
  GetNewsDetailsSuccess(this.model);
}

class GetNewsDetailsError extends NewsState{
  Failures failures;

  GetNewsDetailsError(this.failures);
}