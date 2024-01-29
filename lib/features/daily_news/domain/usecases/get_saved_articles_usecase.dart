import 'package:clean_architect_news_app/core/usecase/usecase.dart';
import 'package:clean_architect_news_app/features/daily_news/data/models/article_model.dart';
import 'package:clean_architect_news_app/features/daily_news/domain/repository/article_repository.dart';

class GetSavedArticleUseCase implements UseCase<List<Articles>, void> {
  final ArticleRepository articleRepository;

  GetSavedArticleUseCase(this.articleRepository);

  @override
  Future<List<Articles>> call({void params}) {
    return articleRepository.getSavedArticles();
  }
}
