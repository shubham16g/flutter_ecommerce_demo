// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CartDao? _cartDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
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
            'CREATE TABLE IF NOT EXISTS `CartItem` (`id` INTEGER NOT NULL, `title` TEXT NOT NULL, `image` TEXT NOT NULL, `price` REAL NOT NULL, `quantity` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CartDao get cartDao {
    return _cartDaoInstance ??= _$CartDao(database, changeListener);
  }
}

class _$CartDao extends CartDao {
  _$CartDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _cartItemInsertionAdapter = InsertionAdapter(
            database,
            'CartItem',
            (CartItem item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'image': item.image,
                  'price': item.price,
                  'quantity': item.quantity
                },
            changeListener),
        _cartItemUpdateAdapter = UpdateAdapter(
            database,
            'CartItem',
            ['id'],
            (CartItem item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'image': item.image,
                  'price': item.price,
                  'quantity': item.quantity
                },
            changeListener),
        _cartItemDeletionAdapter = DeletionAdapter(
            database,
            'CartItem',
            ['id'],
            (CartItem item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'image': item.image,
                  'price': item.price,
                  'quantity': item.quantity
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CartItem> _cartItemInsertionAdapter;

  final UpdateAdapter<CartItem> _cartItemUpdateAdapter;

  final DeletionAdapter<CartItem> _cartItemDeletionAdapter;

  @override
  Stream<List<CartItem>> getAllCartItems() {
    return _queryAdapter.queryListStream('SELECT * FROM CartItem',
        mapper: (Map<String, Object?> row) => CartItem(
            id: row['id'] as int,
            title: row['title'] as String,
            image: row['image'] as String,
            price: row['price'] as double,
            quantity: row['quantity'] as int),
        queryableName: 'CartItem',
        isView: false);
  }

  @override
  Future<CartItem?> getCartItem(int id) async {
    return _queryAdapter.query('SELECT * FROM CartItem WHERE id = ?1',
        mapper: (Map<String, Object?> row) => CartItem(
            id: row['id'] as int,
            title: row['title'] as String,
            image: row['image'] as String,
            price: row['price'] as double,
            quantity: row['quantity'] as int),
        arguments: [id]);
  }

  @override
  Future<void> insertCartItem(CartItem cartItem) async {
    await _cartItemInsertionAdapter.insert(cartItem, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCartItem(CartItem cartItem) async {
    await _cartItemUpdateAdapter.update(cartItem, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCartItem(CartItem cartItem) async {
    await _cartItemDeletionAdapter.delete(cartItem);
  }
}
