import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String name;
  final String category;
  final String description;
  final List<dynamic> imageUrls;
  final bool isRecommended;
  final bool isPopular;
  final bool isTopRated;
  final bool isTodaySpecial;
  double price;
  int quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrls,
    required this.isRecommended,
    required this.isPopular,
    required this.isTopRated,
    required this.isTodaySpecial,
    this.price = 0,
    this.quantity = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        description,
        imageUrls,
        isRecommended,
        isPopular,
        isTopRated,
        isTodaySpecial,
        price,
        quantity,
      ];

  ProductModel copyWith({
    int? id,
    String? name,
    String? category,
    String? description,
    List<dynamic>? imageUrls,
    bool? isRecommended,
    bool? isPopular,
    bool? isTopRated,
    bool? isTodaySpecial,
    double? price,
    int? quantity,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      imageUrls: imageUrls ?? this.imageUrls,
      isRecommended: isRecommended ?? this.isRecommended,
      isPopular: isPopular ?? this.isPopular,
      isTopRated: isTopRated ?? this.isTopRated,
      isTodaySpecial: isTodaySpecial ?? this.isTodaySpecial,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'category': category,
        'description': description,
        'imageUrls': imageUrls,
        'isRecommended': isRecommended,
        'isPopular': isPopular,
        'isTopRated': isTopRated,
        'isTodaySpecial': isTodaySpecial,
        'price': price,
        'quantity': quantity,
      };

  factory ProductModel.fromSnapshot(DocumentSnapshot snap) {
    return ProductModel(
      id: snap['id'],
      name: snap['name'],
      category: snap['category'],
      description: snap['description'],
      imageUrls: snap['imageUrls'],
      isRecommended: snap['isRecommended'],
      isPopular: snap['isPopular'],
      isTopRated: snap['isTopRated'],
      isTodaySpecial: snap['isTodaySpecial'],
      price: snap['price'],
      quantity: snap['quantity'],
    );
  }

  String toJson() => json.encode(toMap());
  
  @override
  bool get stringify => true;

  // static List<ProductModel> products = [
  //   ProductModel(
  //     id: 1,
  //     name: 'Apple',
  //     category: 'Fruits',
  //     description: 'thids dfhsjsnk ffhsdjmfhjk dsffjksjjf  jkhfkls',
  //     imageUrls: ["assets/images/product1.jpg"],
  //     isRecommended: true,
  //     isPopular: false,
  //     isTopRated: true,
  //     isTodaySpecial: false,
  //     price: 1.99,
  //     quantity: 25,
  //   ),
  //   ProductModel(
  //     id: 2,
  //     name: 'Banana',
  //     category: 'Fruits',
  //     description: 'thids dfhsjsnk ffhsdjmfhjk dsffjksjjf  jkhfkls',
  //     imageUrls: ["assets/images/product2.jpg"],
  //     isRecommended: true,
  //     isPopular: false,
  //     isTopRated: true,
  //     isTodaySpecial: false,
  //     price: 1.99,
  //     quantity: 25,
  //   ),
  //   ProductModel(
  //     id: 3,
  //     name: 'Milk',
  //     category: 'Dairy',
  //     description: 'thids dfhsjsnk ffhsdjmfhjk dsffjksjjf  jkhfkls',
  //     imageUrls: ["assets/images/product3.jpeg"],
  //     isRecommended: true,
  //     isPopular: false,
  //     isTopRated: true,
  //     isTodaySpecial: false,
  //     price: 1.99,
  //     quantity: 25,
  //   ),
  //   ProductModel(
  //     id: 4,
  //     name: 'Coca-Cola',
  //     category: 'Drinks',
  //     description: 'thids dfhsjsnk ffhsdjmfhjk dsffjksjjf  jkhfkls',
  //     imageUrls: ["assets/images/product5.jpg"],
  //     isRecommended: true,
  //     isPopular: false,
  //     isTopRated: true,
  //     isTodaySpecial: false,
  //     price: 1.99,
  //     quantity: 25,
  //   ),
  //   ProductModel(
  //     id: 5,
  //     name: 'Rice',
  //     category: 'Grocery',
  //     description: 'thids dfhsjsnk ffhsdjmfhjk dsffjksjjf  jkhfkls',
  //     imageUrls: ["assets/images/product8.jpg"],
  //     isRecommended: true,
  //     isPopular: false,
  //     isTopRated: true,
  //     isTodaySpecial: false,
  //     price: 1.99,
  //     quantity: 25,
  //   ),
  // ];
}
