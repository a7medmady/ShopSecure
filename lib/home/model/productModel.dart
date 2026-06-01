import 'package:e_commerce/home/model/reviewModel.dart';

class ProductModel {
  final int id;
  final String title;
  final String image;
  final double price;
  final String description;
  final double rating;
  final int stock;
  final String brand;
  final String shipping;
  final List<ReviewModel> reviews;
  final String? availability;
  int quantity = 1;

  ProductModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.description,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.shipping,
    required this.reviews,
    required this.availability,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      image: json['thumbnail'] ??
       'https://media.istockphoto.com/id/1502675051/vector/image-preview-icon.jpg?s=612x612&w=0&k=20&c=nUBzhQ0CpH1E3WkiCXuIyd6QiWOJXt5k7HaXpBnLecc=',
      price: json['price'] ?? 0,
      description: json['description'] ?? 'No Description',
      rating: json['rating'] ?? 0,
      stock: json['stock'] ?? 0,
      brand: json['brand'] ?? 'No Brand',
      shipping: json['shippingInformation'] ?? 'No Information Shipping',
      reviews: json['reviews'] != null
          ? List<ReviewModel>.from(
              json['reviews'].map((e) => ReviewModel.fromJson(e)),
            )
          : [],
      availability: json['availabilityStatus'] ?? 'No Status',
    );
  }
}
