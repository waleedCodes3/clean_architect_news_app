import 'package:clean_architect_news_app/core/network/connectivity_service.dart';
import 'package:clean_architect_news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:clean_architect_news_app/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:clean_architect_news_app/features/daily_news/domain/repository/article_repository.dart';
import 'package:clean_architect_news_app/features/daily_news/domain/usecases/get_article_usecase.dart';
import 'package:clean_architect_news_app/features/daily_news/presentation/bloc/article/remote/bloc/remote_article_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
Future<void> initializeDependencies() async {
  //database
  // final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  //Dio
  sl.registerSingleton<Dio>(Dio());

  //dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));
  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl()));

  //usecases
  sl.registerSingleton<GetArticlesUseCase>(GetArticlesUseCase(sl()));

  //blocs
  sl.registerSingleton<RemoteArticleBloc>(RemoteArticleBloc(sl()));

  //connectivity
  sl.registerLazySingleton<ConnectivityService>(() => ConnectivityService());
  sl.registerSingleton<Connectivity>(Connectivity());
}
