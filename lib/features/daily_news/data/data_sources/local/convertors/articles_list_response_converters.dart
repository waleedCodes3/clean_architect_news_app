import 'dart:convert';

import 'package:clean_architect_news_app/features/daily_news/data/models/article_model.dart';
import 'package:floor/floor.dart';

// Converter for List<Articles>
class ArticlesListConverter extends TypeConverter<List<Articles>?, String> {
  @override
  List<Articles>? decode(String databaseValue) {
    if (databaseValue.isNotEmpty) {
      final List<dynamic> list = json.decode(databaseValue);
      return list.map((dynamic e) => Articles.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  @override
  String encode(List<Articles>? value) {
    return json.encode(value!.map((Articles e) => e.toJson()).toList());
  }
}

// Converter for Source
class SourceConverter extends TypeConverter<Source?, String> {
  @override
  Source? decode(String databaseValue) {
    return Source.fromJson(json.decode(databaseValue));
  }

  @override
  String encode(Source? value) {
    return json.encode(value!.toJson());
  }
}
