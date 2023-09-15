import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class BannerModel extends Equatable {
  final int id;
  final String imageUrl;

  const BannerModel({
    required this.id,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        imageUrl,
      ];

  BannerModel copyWith({
    int? id,
    String? imageUrl,
  }) {
    return BannerModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'imageUrl': imageUrl,
      };

  factory BannerModel.fromSnapshot(DocumentSnapshot snap) {
    return BannerModel(
      id: snap['id'],
      imageUrl: snap['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  
}
