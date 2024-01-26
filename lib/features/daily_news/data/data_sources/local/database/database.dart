import 'package:clean_architect_news_app/features/daily_news/data/data_sources/local/convertors/articles_list_response_converters.dart';
import 'package:clean_architect_news_app/features/daily_news/data/data_sources/local/dao/article_dao.dart';
import 'package:clean_architect_news_app/features/daily_news/data/models/article_model.dart';
import 'package:floor/floor.dart';

part 'database.g.dart';

@Database(version: 1, entities: [ArticlesListResponse])
@TypeConverters(
  [
    ArticlesListConverter,
    SourceConverter,
  ],
)
abstract class Appdatabase extends FloorDatabase {
  ArticleListDao get articleListDao;
}
