import 'package:clean_architect_news_app/core/resources/data_state.dart';
import 'package:clean_architect_news_app/features/daily_news/data/models/article_model.dart';
import 'package:clean_architect_news_app/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<DataState<ArticlesListResponseEntity>> getNewsArticles();

  //databaseMethods
  Future<ArticlesListResponse?> getArticlesListResponse();
  Future<bool> saveArticle(Articles article);
  Future<List<Articles>> getSavedArticles();
  Future<bool> deleteArticle(String title);
  
}
