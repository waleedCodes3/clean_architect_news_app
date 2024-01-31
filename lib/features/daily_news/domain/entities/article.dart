import '../../data/models/article_model.dart';

class ArticlesListResponseEntity {
   String? status;
   int? totalResults;
   List<Articles>? articles;

  ArticlesListResponseEntity({this.status, this.totalResults, this.articles});
}
