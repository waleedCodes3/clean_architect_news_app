import 'package:clean_architect_news_app/features/daily_news/data/models/article_model.dart';
import 'package:clean_architect_news_app/features/daily_news/presentation/pages/article_detail.dart';
import 'package:clean_architect_news_app/features/daily_news/presentation/pages/daily_news.dart';
import 'package:clean_architect_news_app/features/daily_news/presentation/pages/saved_articles.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const DailyNews());

      case '/ArticleDetails':
        final ArticleDetailsArguments args =
            settings.arguments as ArticleDetailsArguments;
        return _materialRoute(ArticleDetailsView(
          article: args.article,
          x: args.x,
        ));

      case '/SavedArticles':
        return _materialRoute(const SavedArticles());

      default:
        return _materialRoute(const DailyNews());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}

class ArticleDetailsArguments {
  final Articles? article;
  final int? x; // Another argument

  ArticleDetailsArguments({required this.article, required this.x});
}
