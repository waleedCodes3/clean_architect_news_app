import 'package:clean_architect_news_app/core/constants/constants.dart';
import 'package:clean_architect_news_app/features/daily_news/data/models/article_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: newApiBaseURl)
abstract class NewsApiService {
  factory NewsApiService(Dio dio, {String baseUrl}) = _NewsApiService;

  @GET("top-headlines")
  Future<HttpResponse<ArticlesListResponse>> getNewsArticle({
    @Query('apiKey') String? apiKey,
    @Query('country') String? country,
    @Query('category') String? category,
  });
}
