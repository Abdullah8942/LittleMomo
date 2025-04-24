import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:littlemomo/models/product_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('littlemomo.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        price REAL NOT NULL,
        imagePath TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE cart (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productId INTEGER NOT NULL,
        quantity INTEGER NOT NULL,
        FOREIGN KEY (productId) REFERENCES products (id)
      )
    ''');
  }

  // CRUD for Products
  Future<int> insertProduct(Product product) async {
    final db = await instance.database;
    return await db.insert('products', product.toMap());
  }

  Future<List<Product>> getProducts() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  Future<Product?> getProduct(int id) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Product.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateProduct(Product product) async {
    final db = await instance.database;
    return await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> deleteProduct(int id) async {
    final db = await instance.database;
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Cart operations
  Future<int> addToCart(int productId, int quantity) async {
    final db = await instance.database;
    
    // Check if product already exists in cart
    final List<Map<String, dynamic>> existingItems = await db.query(
      'cart',
      where: 'productId = ?',
      whereArgs: [productId],
    );

    if (existingItems.isNotEmpty) {
      // Update existing cart item
      final existingItem = existingItems.first;
      final newQuantity = existingItem['quantity'] + quantity;
      
      return await db.update(
        'cart',
        {'quantity': newQuantity},
        where: 'id = ?',
        whereArgs: [existingItem['id']],
      );
    } else {
      // Add new cart item
      return await db.insert('cart', {
        'productId': productId,
        'quantity': quantity,
      });
    }
  }

  Future<int> updateCartItemQuantity(int cartItemId, int quantity) async {
    final db = await instance.database;
    return await db.update(
      'cart',
      {'quantity': quantity},
      where: 'id = ?',
      whereArgs: [cartItemId],
    );
  }

  Future<int> removeFromCart(int cartItemId) async {
    final db = await instance.database;
    return await db.delete(
      'cart',
      where: 'id = ?',
      whereArgs: [cartItemId],
    );
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await instance.database;
    
    return await db.rawQuery('''
      SELECT c.id as cartId, c.quantity, p.*
      FROM cart c
      JOIN products p ON c.productId = p.id
    ''');
  }

  Future<void> clearCart() async {
    final db = await instance.database;
    await db.delete('cart');
  }

  // Close database
  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
} 