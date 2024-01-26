import 'dart:convert';

import 'package:clean_architect_news_app/features/daily_news/data/models/article_model.dart';
import 'package:floor/floor.dart';

// Converter for List<Articles>
class ArticlesListConverter extends TypeConverter<List<Articles>, String> {
  @override
  List<Articles> decode(String databaseValue) {
    return (json.decode(databaseValue) as List)
        .map<Articles>((item) => Articles.fromJson(item))
        .toList();
  }

  @override
  String encode(List<Articles> value) {
    return json.encode(value.map((item) => item.toJson()).toList());
  }
}

// Converter for Source
class SourceConverter extends TypeConverter<Source, String> {
  @override
  Source decode(String databaseValue) {
    return Source.fromJson(json.decode(databaseValue));
  }

  @override
  String encode(Source value) {
    return json.encode(value.toJson());
  }
}
