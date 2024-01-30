import 'package:clean_architect_news_app/core/usecase/usecase.dart';
import 'package:clean_architect_news_app/features/daily_news/domain/repository/article_repository.dart';

class DeleteArticleUseCase implements UseCase<bool, String> {
  final ArticleRepository articleRepository;

  DeleteArticleUseCase(this.articleRepository);

  @override
  Future<bool> call({String? params}) {
    return articleRepository.deleteArticle(params!);
  }
}
