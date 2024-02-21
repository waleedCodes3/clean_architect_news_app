part of 'remote_article_bloc.dart';

abstract class RemoteArticleEvent {
  const RemoteArticleEvent();
}

final class GetArticlesEvent extends RemoteArticleEvent {}
