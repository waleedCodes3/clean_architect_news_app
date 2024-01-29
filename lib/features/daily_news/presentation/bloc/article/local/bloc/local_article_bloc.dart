// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_architect_news_app/features/daily_news/data/models/article_model.dart';
import 'package:clean_architect_news_app/features/daily_news/domain/usecases/get_saved_articles_usecase.dart';
import 'package:clean_architect_news_app/features/daily_news/domain/usecases/save_article_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'local_article_event.dart';
part 'local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  SaveArticleUseCase saveArticleUseCase;
  GetSavedArticleUseCase getSavedArticleUseCase;
  LocalArticleBloc(
    this.saveArticleUseCase,
    this.getSavedArticleUseCase,
  ) : super(LocalArticleInitial()) {
    on<SaveArticleLocallyEvent>((event, emit) async {
      await _saveArticleLocally(event, emit);
    });
    on<ResetLocalArticleBlocEvent>((event, emit) {
      emit(LocalArticleInitial());
    });
    on<GetLocallaySavedArticlesEvent>((event, emit) async {
      await _getSavedArticlesEvent(event, emit);
    });
  }

  _saveArticleLocally(
      SaveArticleLocallyEvent event, Emitter<LocalArticleState> emit) async {
    // emit(const ());
    emit(LocalArticleSavingState());
    await Future.delayed(const Duration(seconds: 5));

    final articleSaved = await saveArticleUseCase.call(params: event.article);
    if (articleSaved) {
      emit(LocalArticleSavedState());
    } else {
      emit(const LocalArticleErrorState("Failed to save Locally"));
    }
  }

  _getSavedArticlesEvent(GetLocallaySavedArticlesEvent event,
      Emitter<LocalArticleState> emit) async {
    emit(LocalArticlesFetchingState());
    await Future.delayed(const Duration(seconds: 5));

    final articlesList = await getSavedArticleUseCase.call();
    if (articlesList.isNotEmpty) {
      emit(LocalArticlesFetchedState(articlesList));
    } else {
      emit(const LocalArticleErrorState("Failed to save Locally"));
    }
  }
}
