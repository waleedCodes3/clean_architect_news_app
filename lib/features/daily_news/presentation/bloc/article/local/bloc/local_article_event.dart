part of 'local_article_bloc.dart';

sealed class LocalArticleEvent extends Equatable {
  const LocalArticleEvent();

  @override
  List<Object> get props => [];
}

final class GetLocallaySavedArticlesEvent extends LocalArticleEvent {}
final class ResetLocalArticleBlocEvent extends LocalArticleEvent{}

final class SaveArticleLocallyEvent extends LocalArticleEvent {
  final Articles article;

  const SaveArticleLocallyEvent(this.article);
}
final class GetSavedArticlesEvent extends LocalArticleState{}
