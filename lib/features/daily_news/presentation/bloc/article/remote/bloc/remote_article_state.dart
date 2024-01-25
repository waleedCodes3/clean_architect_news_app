part of 'remote_article_bloc.dart';

sealed class RemoteArticleState extends Equatable {
  final DioException? error;
  final List<Articles>? articles;
  const RemoteArticleState({this.error, this.articles});

  @override
  List<Object> get props => [error!, articles!];
}

final class RemoteArticleInitial extends RemoteArticleState {}

final class RemoteArticleLoading extends RemoteArticleState {
  const RemoteArticleLoading();
}

final class RemoteArticleDone extends RemoteArticleState {
  const RemoteArticleDone(List<Articles>? articles)
      : super(articles: articles);
}
final class RemoteArticleError extends RemoteArticleState {
  const RemoteArticleError(DioException? error) : super(error: error);
}
