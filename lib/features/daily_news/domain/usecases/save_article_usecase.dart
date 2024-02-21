import 'package:clean_architect_news_app/core/usecase/usecase.dart';
import 'package:clean_architect_news_app/features/daily_news/data/models/article_model.dart';
import 'package:clean_architect_news_app/features/daily_news/domain/repository/article_repository.dart';

class SaveArticleUseCase implements UseCase<void, Articles> {
  final ArticleRepository articleRepository;

  SaveArticleUseCase(this.articleRepository);

  @override
  Future<bool> call({Articles? params}) {
    return articleRepository.saveArticle(params!);
  }
}
