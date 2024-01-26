import 'package:clean_architect_news_app/features/daily_news/data/models/article_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class ArticleListDao {
  @Insert()
  Future<void> insertArticleDao(ArticlesListResponse articlesListResponse);

  @Query("Select * FROM articles_table")
  Future<ArticlesListResponse> getArticles();
}
