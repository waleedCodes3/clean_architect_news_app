import 'package:clean_architect_news_app/features/daily_news/data/data_sources/local/convertors/articles_list_response_converters.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../data/models/article_model.dart';

class ArticleEntity extends Equatable {
  final int? id;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const ArticleEntity(
      {this.id,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  @override
  List<Object?> get props {
    return [
      id,
      author,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content
    ];
  }
}

class ArticlesListResponseEntity {
  final String? status;
  final int? totalResults;

  @TypeConverters([ArticlesListConverter])
  final List<Articles>? articles;

  ArticlesListResponseEntity({this.status, this.totalResults, this.articles});
}
