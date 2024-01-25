import 'package:clean_architect_news_app/core/resources/data_state.dart';
import 'package:clean_architect_news_app/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<DataState<ArticlesListResponseEntity>> getNewsArticles();
}
