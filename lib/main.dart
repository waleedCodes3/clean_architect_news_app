import 'package:alice/alice.dart';
import 'package:clean_architect_news_app/config/routes/routes.dart';
import 'package:clean_architect_news_app/dependency_injection.dart';
import 'package:clean_architect_news_app/features/daily_news/presentation/bloc/article/local/bloc/local_article_bloc.dart';
import 'package:clean_architect_news_app/features/daily_news/presentation/bloc/article/remote/bloc/remote_article_bloc.dart';
import 'package:clean_architect_news_app/features/daily_news/presentation/pages/daily_news.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Alice alice = Alice(
    showNotification: true,
    showInspectorOnShake: !kReleaseMode,
    maxCallsCount: 1000,
    navigatorKey: Alice().getNavigatorKey());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kReleaseMode) {
      navigatorKey = alice.getNavigatorKey() ?? navigatorKey;
    }
    return MultiBlocProvider(
      providers: [
        // Add BlocProvider for RemoteArticleBloc
        BlocProvider<RemoteArticleBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<LocalArticleBloc>(
          create: (context) => sl(),
        ),
        // Add other BlocProviders here
        // Example:
        // BlocProvider<AnotherBloc>(
        //   create: (context) => sl<AnotherBloc>(),
        // ),
      ],
      child: MaterialApp(
        title: 'Flutter News App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        navigatorKey: navigatorKey,
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const DailyNews(),
      ),
    );
  }
}
