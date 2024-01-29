import 'package:clean_architect_news_app/core/resources/data_state.dart';
import 'package:clean_architect_news_app/features/daily_news/data/models/article_model.dart';
import 'package:clean_architect_news_app/features/daily_news/domain/entities/article.dart';
import 'package:clean_architect_news_app/features/daily_news/domain/usecases/get_articles_list_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'remote_article_event.dart';
part 'remote_article_state.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticlesUseCase getArticlesUseCase;
  RemoteArticleBloc(this.getArticlesUseCase) : super(RemoteArticleInitial()) {
    on<GetArticlesEvent>((event, emit) async {
      await getArticles(event, emit);
    });
  }

  getArticles(
      RemoteArticleEvent event, Emitter<RemoteArticleState> emit) async {
    emit(const RemoteArticleLoading());
    final DataState<ArticlesListResponseEntity> dataState = await getArticlesUseCase();
    if (dataState is DataSuccess && dataState.data!.articles!.isNotEmpty) {
      emit(RemoteArticleDone(dataState.data!.articles!));
    } else if (dataState is DataFailed) {
      emit(RemoteArticleError(dataState.error));
    }
  }
}
