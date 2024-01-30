// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppdatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppdatabaseBuilder databaseBuilder(String name) =>
      _$AppdatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppdatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppdatabaseBuilder(null);
}

class _$AppdatabaseBuilder {
  _$AppdatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppdatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppdatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<Appdatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$Appdatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$Appdatabase extends Appdatabase {
  _$Appdatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ArticleListDao? _articleListDaoInstance;

  SavedArticlesDao? _savedArticlesDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 4,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `articles_list_response_table` (`status` TEXT, `totalResults` INTEGER, `articles` TEXT, PRIMARY KEY (`status`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `articles_table` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `source` TEXT, `author` TEXT, `title` TEXT, `description` TEXT, `url` TEXT, `urlToImage` TEXT, `publishedAt` TEXT, `content` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ArticleListDao get articleListDao {
    return _articleListDaoInstance ??=
        _$ArticleListDao(database, changeListener);
  }

  @override
  SavedArticlesDao get savedArticlesDao {
    return _savedArticlesDaoInstance ??=
        _$SavedArticlesDao(database, changeListener);
  }
}

class _$ArticleListDao extends ArticleListDao {
  _$ArticleListDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _articlesListResponseInsertionAdapter = InsertionAdapter(
            database,
            'articles_list_response_table',
            (ArticlesListResponse item) => <String, Object?>{
                  'status': item.status,
                  'totalResults': item.totalResults,
                  'articles': _articlesListConverter.encode(item.articles),
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ArticlesListResponse>
      _articlesListResponseInsertionAdapter;

  @override
  Future<ArticlesListResponse?> getArticles() async {
    return _queryAdapter.query('Select * FROM articles_list_response_table',
        mapper: (Map<String, Object?> row) => ArticlesListResponse(
            status: row['status'] as String?,
            totalResults: row['totalResults'] as int?,
            articles:
                _articlesListConverter.decode(row['articles'] as String)));
  }

  @override
  Future<void> insertArticleDao(
      ArticlesListResponse articlesListResponse) async {
    await _articlesListResponseInsertionAdapter.insert(
        articlesListResponse, OnConflictStrategy.replace);
  }
}

class _$SavedArticlesDao extends SavedArticlesDao {
  _$SavedArticlesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _articlesInsertionAdapter = InsertionAdapter(
            database,
            'articles_table',
            (Articles item) => <String, Object?>{
                  'id': item.id,
                  'source': _sourceConverter.encode(item.source),
                  'author': item.author,
                  'title': item.title,
                  'description': item.description,
                  'url': item.url,
                  'urlToImage': item.urlToImage,
                  'publishedAt': item.publishedAt,
                  'content': item.content
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Articles> _articlesInsertionAdapter;

  @override
  Future<List<Articles>> getSavedArticles() async {
    return _queryAdapter.queryList('Select * FROM articles_table',
        mapper: (Map<String, Object?> row) => Articles(
            source: _sourceConverter.decode(row['source'] as String),
            author: row['author'] as String?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            url: row['url'] as String?,
            urlToImage: row['urlToImage'] as String?,
            publishedAt: row['publishedAt'] as String?,
            content: row['content'] as String?));
  }

  @override
  Future<void> deleteArticle(String title) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM articles_table WHERE title = ?1',
        arguments: [title]);
  }

  @override
  Future<void> saveArticle(Articles article) async {
    await _articlesInsertionAdapter.insert(article, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _articlesListConverter = ArticlesListConverter();
final _sourceConverter = SourceConverter();
