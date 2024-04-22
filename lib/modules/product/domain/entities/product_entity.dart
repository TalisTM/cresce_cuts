import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final String category;
  final String description;
  final String image;
  const ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        category,
        description,
        image,
      ];
}
