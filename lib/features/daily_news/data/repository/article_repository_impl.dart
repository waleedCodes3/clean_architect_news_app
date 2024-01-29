import 'dart:io';

import 'package:clean_architect_news_app/core/constants/constants.dart';
import 'package:clean_architect_news_app/core/network/connectivity_service.dart';
import 'package:clean_architect_news_app/core/resources/data_state.dart';
import 'package:clean_architect_news_app/dependency_injection.dart';
import 'package:clean_architect_news_app/features/daily_news/data/data_sources/local/database/database.dart';
import 'package:clean_architect_news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:clean_architect_news_app/features/daily_news/data/models/article_model.dart';
import 'package:clean_architect_news_app/features/daily_news/domain/repository/article_repository.dart';
import 'package:dio/dio.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final Appdatabase _appdatabase;

  ArticleRepositoryImpl(this._newsApiService, this._appdatabase);
  @override
  Future<DataState<ArticlesListResponse>> getNewsArticles() async {
    bool isConnected = sl<ConnectivityService>().isConnected;

    if (isConnected) {
      try {
        final httpResponse = await _newsApiService.getNewsArticle(
            apiKey: apiKey, category: category, country: country);
        if (httpResponse.response.statusCode == HttpStatus.ok) {
          _appdatabase.articleListDao.insertArticleDao(httpResponse.data);
          return DataSuccess(httpResponse.data);
        } else {
          return DataFailed(DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.badResponse,
              requestOptions: httpResponse.response.requestOptions));
        }
      } on DioException catch (e) {
        return DataFailed(e);
      }
    } else {
      var data = await getArticlesListResponse();
      if (data != null) {
        return DataSuccess(data);
      }

      return DataFailed(DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.connectionError,
          message: "no offline data found"));
    }
  }

  @override
  Future<ArticlesListResponse?> getArticlesListResponse() {
    return _appdatabase.articleListDao.getArticles();
  }
}
