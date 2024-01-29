import 'package:clean_architect_news_app/features/daily_news/data/models/article_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class ArticleListDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertArticleDao(ArticlesListResponse articlesListResponse);

  @Query("Select * FROM articles_list_response_table")
  Future<ArticlesListResponse?> getArticles();
}
