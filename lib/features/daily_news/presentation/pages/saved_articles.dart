import 'package:clean_architect_news_app/dependency_injection.dart';
import 'package:clean_architect_news_app/features/daily_news/data/models/article_model.dart';
import 'package:clean_architect_news_app/features/daily_news/presentation/bloc/article/local/bloc/local_article_bloc.dart';
import 'package:clean_architect_news_app/features/daily_news/presentation/widgets/article_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class SavedArticles extends StatefulWidget {
  const SavedArticles({Key? key}) : super(key: key);

  @override
  State<SavedArticles> createState() => _SavedArticlesState();
}

class _SavedArticlesState extends State<SavedArticles> {
  @override
  void initState() {
    // TODO: implement initState
    sl<LocalArticleBloc>().add(GetLocallaySavedArticlesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("rebild.....................");
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: const Icon(Ionicons.chevron_back, color: Colors.black),
        ),
      ),
      title:
          const Text('Saved Articles', style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LocalArticleBloc, LocalArticleState>(
      builder: (context, state) {
        if (state is LocalArticlesFetchingState) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state is LocalArticlesFetchedState) {
          return _buildArticlesList(state.articles);
        }
        return Container();
      },
    );
  }

  Widget _buildArticlesList(List<Articles> articles) {
    if (articles.isEmpty) {
      return const Center(
          child: Text(
        'NO SAVED ARTICLES',
        style: TextStyle(color: Colors.black),
      ));
    }

    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async => _onArticlePressed(context, articles[index]),
          child: ArticleWidget(
            article: articles[index],
            isRemovable: true,
            // onRemove: (article) => _onRemoveArticle(context, article),
            // onArticlePressed: (article) => _onArticlePressed(context, article),
          ),
        );
      },
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  // void _onRemoveArticle(BuildContext context, ArticleEntity article) {
  void _onArticlePressed(BuildContext context, Articles article) async {
    await Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
    onpageRevisited();
  }

  void onpageRevisited() {
    if (sl<LocalArticleBloc>().state is! LocalArticlesFetchedState) {
      sl<LocalArticleBloc>().add(GetLocallaySavedArticlesEvent());
    }
  }
}
