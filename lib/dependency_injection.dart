import 'package:clean_architect_news_app/core/network/connectivity_service.dart';
import 'package:clean_architect_news_app/features/daily_news/data/data_sources/local/database/database.dart';
import 'package:clean_architect_news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:clean_architect_news_app/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:clean_architect_news_app/features/daily_news/domain/repository/article_repository.dart';
import 'package:clean_architect_news_app/features/daily_news/domain/usecases/get_articles_list_usecase.dart';
import 'package:clean_architect_news_app/features/daily_news/domain/usecases/get_saved_articles_usecase.dart';
import 'package:clean_architect_news_app/features/daily_news/domain/usecases/save_article_usecase.dart';
import 'package:clean_architect_news_app/features/daily_news/presentation/bloc/article/local/bloc/local_article_bloc.dart';
import 'package:clean_architect_news_app/features/daily_news/presentation/bloc/article/remote/bloc/remote_article_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
Future<void> initializeDependencies() async {
  //database
  final database =
      await $FloorAppdatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton(database);

  //Dio
  sl.registerSingleton<Dio>(Dio());

  //dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));
  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl(), sl()));

  //usecases
  sl.registerSingleton<GetArticlesUseCase>(GetArticlesUseCase(sl()));
  sl.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(sl()));
  sl.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(sl()));

  //blocs
  sl.registerSingleton<RemoteArticleBloc>(RemoteArticleBloc(sl()));
  sl.registerSingleton<LocalArticleBloc>(LocalArticleBloc(sl(), sl()));

  //connectivity
  sl.registerSingleton<ConnectivityService>(ConnectivityService());
  sl.registerSingleton<Connectivity>(Connectivity());
}
