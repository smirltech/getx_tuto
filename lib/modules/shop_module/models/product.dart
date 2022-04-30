class Product {
  int? id;
  String? title;
  String? description;
  String? thumbnail;
  double? discountPercentage;
  double? rating;
  double? price;
  String? brand;
  int? quantity;
  String? category;
  List<String>? images;

  Product({
    this.id,
    this.title,
    this.description,
    this.thumbnail,
    this.discountPercentage,
    this.rating,
    this.price,
    this.brand,
    this.quantity,
    this.category,
    this.images,
  });

  factory Product.fromMap(Map<String, dynamic> map) => Product(
        id: map["id"],
        title: map["title"],
        description: map["description"],
        thumbnail: map["thumbnail"],
        discountPercentage: map["discountPercentage"].toDouble(),
        rating: map["rating"].toDouble(),
        price: map["price"].toDouble(),
        brand: map["brand"],
        quantity: map["quantity"],
        category: map["category"],
        images: List<String>.from(map["images"].map((x) => x)),
      );

  static List<Product> listFromMap(List<dynamic> list) {
    List<Product> _list = list.map((map) => Product.fromMap(map)).toList();

    return _list;
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "thumbnail": thumbnail,
        "discountPercentage": discountPercentage,
        "rating": rating,
        "price": price,
        "brand": brand,
        "quantity": quantity,
        "category": category,
        "images": images,
      };

  discount() {
    return (price! * discountPercentage!) / 100;
  }

  discountedPrice() {
    return price! - discount();
  }

  @override
  String toString() {
    return 'Product{id: $id, title: $title, description: $description, thumbnail: $thumbnail, discountPercentage: $discountPercentage, rating: $rating, price: $price, brand: $brand, quantity: $quantity, category: $category, images: $images}';
  }
}
