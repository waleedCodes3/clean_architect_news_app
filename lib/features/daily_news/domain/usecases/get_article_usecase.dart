import 'package:clean_architect_news_app/core/resources/data_state.dart';
import 'package:clean_architect_news_app/core/usecase/usecase.dart';
import 'package:clean_architect_news_app/features/daily_news/domain/entities/article.dart';
import 'package:clean_architect_news_app/features/daily_news/domain/repository/article_repository.dart';

class GetArticlesUseCase
    implements UseCase<DataState<ArticlesListResponseEntity>, void> {
  final ArticleRepository articleRepository;

  GetArticlesUseCase(this.articleRepository);
  @override
  Future<DataState<ArticlesListResponseEntity>> call({void params}) {
    return articleRepository.getNewsArticles();
  }
}
