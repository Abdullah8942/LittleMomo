class Product {
  final int id;
  final String name;
  final String category;
  final double price;
  final String imagePath;
  final String? description;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imagePath,
    this.description,
  });

  // Convert Product object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'imagePath': imagePath,
      'description': description,
    };
  }

  // Create a Product object from a Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      price: map['price'],
      imagePath: map['imagePath'],
      description: map['description'],
    );
  }

  // Copy with function to create a new instance with updated values
  Product copyWith({
    int? id,
    String? name,
    String? category,
    double? price,
    String? imagePath,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
    );
  }
} 