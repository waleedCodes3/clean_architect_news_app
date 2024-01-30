import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architect_news_app/dependency_injection.dart';
import 'package:clean_architect_news_app/features/daily_news/data/models/article_model.dart';
import 'package:clean_architect_news_app/features/daily_news/presentation/bloc/article/local/bloc/local_article_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class ArticleDetailsView extends StatefulWidget {
  final Articles? article;
  final int? x;

  const ArticleDetailsView({Key? key, this.article, this.x}) : super(key: key);

  @override
  State<ArticleDetailsView> createState() => _ArticleDetailsViewState();
}

class _ArticleDetailsViewState extends State<ArticleDetailsView> {
  @override
  void initState() {
    // sl<LocalArticleBloc>().add(ResetLocalArticleBlocEvent());
    super.initState();
    debugPrint(widget.x.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
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
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildArticleTitleAndDate(),
          _buildArticleImage(),
          _buildArticleDescription(),
        ],
      ),
    );
  }

  Widget _buildArticleTitleAndDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            widget.article!.title!,
            style: const TextStyle(
                fontFamily: 'Butler',
                fontSize: 20,
                fontWeight: FontWeight.w900),
          ),

          const SizedBox(height: 14),
          // DateTime
          Row(
            children: [
              const Icon(Ionicons.time_outline, size: 16),
              const SizedBox(width: 4),
              Text(
                widget.article!.publishedAt!,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArticleImage() {
    return Container(
        width: double.maxFinite,
        height: 250,
        margin: const EdgeInsets.only(top: 14),
        child: CachedNetworkImage(
            imageUrl: widget.article!.urlToImage ?? "",
            imageBuilder: (context, imageProvider) => ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.08),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ),
                ),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                    ),
                    child: const CupertinoActivityIndicator(),
                  ),
                ),
            errorWidget: (context, url, error) => Padding(
                  padding: const EdgeInsetsDirectional.only(end: 14, start: 14),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.08),
                      ),
                      child: const Icon(Icons.error),
                    ),
                  ),
                )));
  }

  Widget _buildArticleDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      child: Text(
        '${widget.article!.description ?? 'no description'}\n\n${widget.article!.content ?? 'no content'}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return BlocBuilder<LocalArticleBloc, LocalArticleState>(
        buildWhen: (previousState, currentState) {
      // Only rebuild if the current state is loaded or error
      return sl<LocalArticleBloc>().state is! LocalArticleInitial;
    }, builder: (context, state) {
      if (state is LocalArticleInitial) {
        return FloatingActionButton(
            onPressed: () {
              sl<LocalArticleBloc>()
                  .add(SaveArticleLocallyEvent(widget.article!));
            },
            child: const Icon(Ionicons.bookmark_outline, color: Colors.white));
      } else if (state is LocalArticleSavingState) {
        return FloatingActionButton(
            onPressed: () {},
            // onPressed: () => _onFloatingActionButtonPressed(context),
            child: const CircularProgressIndicator());
      } else if (state is LocalArticleSavedState) {
        return FloatingActionButton(
            onPressed: () {},
            // onPressed: () => _onFloatingActionButtonPressed(context),
            child: const Icon(Ionicons.bookmark, color: Colors.white));
      }
      return const SizedBox();
      // },

      // builder: (context) => FloatingActionButton(
      // onPressed: () => _onFloatingActionButtonPressed(context),
      // child: const Icon(Ionicons.bookmark_outline, color: Colors.white),
      // ),
    });
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  // void _onFloatingActionButtonPressed(BuildContext context) {
  //   // BlocProvider.of<LocalArticleBloc>(context).add(SaveArticle(article!));

  //   // ScaffoldMessenger.of(context).showSnackBar(
  //   //   const SnackBar(
  //   //     backgroundColor: Colors.black,
  //   //     content: Text('Article saved successfully.'),
  //   //   ),
  //   // );
  // }
}
