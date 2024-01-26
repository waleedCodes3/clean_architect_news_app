import 'package:clean_architect_news_app/dependency_injection.dart';
import 'package:clean_architect_news_app/features/daily_news/presentation/bloc/article/remote/bloc/remote_article_bloc.dart';
import 'package:clean_architect_news_app/features/daily_news/presentation/pages/daily_news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Add BlocProvider for RemoteArticleBloc
        BlocProvider<RemoteArticleBloc>(
          create: (context) => sl(),
        ),
        // Add other BlocProviders here
        // Example:
        // BlocProvider<AnotherBloc>(
        //   create: (context) => sl<AnotherBloc>(),
        // ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const DailyNews(),
      ),
    );
  }
}




