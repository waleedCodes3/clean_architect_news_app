import 'package:clean_architect_news_app/features/daily_news/data/models/article_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class SavedArticlesDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveArticle(Articles article);

  @Query("Select * FROM articles_table")
  Future<List<Articles>> getSavedArticles();
}
