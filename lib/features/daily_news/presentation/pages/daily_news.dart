import 'dart:async';

import 'package:clean_architect_news_app/config/routes/routes.dart';
import 'package:clean_architect_news_app/core/network/connectivity_service.dart';
import 'package:clean_architect_news_app/dependency_injection.dart';
import 'package:clean_architect_news_app/features/daily_news/data/models/article_model.dart';
import 'package:clean_architect_news_app/features/daily_news/presentation/bloc/article/remote/bloc/remote_article_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/article_tile.dart';

class DailyNews extends StatefulWidget {
  const DailyNews({super.key});

  @override
  State<DailyNews> createState() => _DailyNewsState();
}

class _DailyNewsState extends State<DailyNews> {
  final _connectivityService = sl<ConnectivityService>();
  late StreamSubscription<ConnectivityResult> streamSubScription;

  @override
  void initState() {
    streamSubScription = _connectivityService.startConnectvityCheckerStream();
    sl<RemoteArticleBloc>().add(GetArticlesEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        sl<RemoteArticleBloc>().add(GetArticlesEvent());
      },
      child: Scaffold(
        appBar: _appbar(),
        body: _body(),
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/SavedArticles');
          },
          icon: const Icon(Icons.bookmark),
        )
      ],
      title: const Text("Daily News"),
      centerTitle: true,
    );
  }

  _body() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
      builder: (context, state) {
        if (state is RemoteArticleLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RemoteArticleError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.error!.message!.toString(),
                ),
                IconButton(
                    onPressed: () {
                      sl<RemoteArticleBloc>().add(GetArticlesEvent());
                    },
                    icon: const Icon(Icons.refresh))
              ],
            ),
          );
        } else if (state is RemoteArticleDone) {
          return state.articles != null
              ? ListView.builder(
                  itemCount: state.articles!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        _onArticlePressed(context, state.articles![index]);
                      },
                      child: ArticleWidget(
                        article: state.articles![index],
                      ),
                    );
                  },
                )
              : const CircularProgressIndicator();
        } else {
          return Container(
            color: Colors.red,
          );
        }
      },
    );
  }

  void _onArticlePressed(BuildContext context, Articles article) {
    Navigator.pushNamed(context, '/ArticleDetails',
        arguments: ArticleDetailsArguments(article: article, x: 45));
  }
}
