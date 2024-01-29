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

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
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
            'CREATE TABLE IF NOT EXISTS `articles_list_response_table` (`status` TEXT, `totalResults` INTEGER, `articles` TEXT,PRIMARY KEY (`totalResults`))');

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
                  'articles': _articlesListConverter.encode(item.articles),
                  'totalResults': item.totalResults,
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

// ignore_for_file: unused_element
final _articlesListConverter = ArticlesListConverter();
final _sourceConverter = SourceConverter();
