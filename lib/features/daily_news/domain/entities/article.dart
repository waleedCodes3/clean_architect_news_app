import '../../data/models/article_model.dart';

class ArticlesListResponseEntity {
  final String? status;
  final int? totalResults;
  final List<Articles>? articles;

  ArticlesListResponseEntity({this.status, this.totalResults, this.articles});
}
