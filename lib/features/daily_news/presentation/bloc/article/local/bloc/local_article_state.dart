part of 'local_article_bloc.dart';

sealed class LocalArticleState extends Equatable {
  const LocalArticleState();

  @override
  List<Object> get props => [];
}

final class LocalArticleInitial extends LocalArticleState {}

final class LocalArticleSavingState extends LocalArticleState {}

final class LocalArticleSavedState extends LocalArticleState {}

final class LocalArticlesFetchedState extends LocalArticleState {
  final List<Articles> articles;

  const LocalArticlesFetchedState(this.articles);
}

final class LocalArticlesFetchingState extends LocalArticleState {}

final class LocalArticleErrorState extends LocalArticleState {
  final String error;

  const LocalArticleErrorState(this.error);
}
