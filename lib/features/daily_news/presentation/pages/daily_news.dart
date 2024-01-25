import 'package:clean_architect_news_app/dependency_injection.dart';
import 'package:clean_architect_news_app/features/daily_news/presentation/bloc/article/remote/bloc/remote_article_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/article_tile.dart';

class DailyNews extends StatefulWidget {
  const DailyNews({super.key});

  @override
  State<DailyNews> createState() => _DailyNewsState();
}

class _DailyNewsState extends State<DailyNews> {
  @override
  void initState() {
    sl<RemoteArticleBloc>().add(GetArticlesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
    );
  }

  AppBar _appbar() {
    return AppBar(
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
          return Text(state.error.toString());
        } else if (state is RemoteArticleDone) {
          return state.articles != null
              ? ListView.builder(
                  itemCount: state.articles!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ArticleWidget(
                      article: state.articles![index],
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
}
