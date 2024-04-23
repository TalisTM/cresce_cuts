import '../../domain/entities/product_entity.dart';

class ProductMapper {
  ProductMapper._();

  static ProductEntity fromMap(Map<String, dynamic> map) {
    return ProductEntity(
      id: map['id'],
      title: map['title'],
      price: double.parse(map['price'].toString()),
      category: map['category'],
      description: map['description'],
      image: map['image'],
    );
  }

  static Map<String, dynamic> toMap(ProductEntity product) {
    return <String, dynamic>{
      'id': product.id,
      'title': product.title,
      'price': product.price,
      'category': product.category,
      'description': product.description,
      'image': product.image,
    };
  }
}
