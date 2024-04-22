import '../../domain/entities/product_entity.dart';

class ProductMapper {
  ProductMapper._();
  
  static ProductEntity fromMap(Map<String, dynamic> map) {
    return ProductEntity(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      category: map['category'],
      description: map['description'],
      image: map['image'],
    );
  }
}
