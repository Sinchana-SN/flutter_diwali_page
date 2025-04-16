import 'package:flutter_riverpod/flutter_riverpod.dart';

final rocketProvider = StateProvider((ref) => [1.2, 1.4, 1.6]);

final categoriesProvider = Provider<List<Map<String, String>>>((ref) {
  return [
    {"title": "T-Shirts", "discount": "40-80% OFF", "image": "images/tshirts.jpg"},
    {"title": "Sports Shoes", "discount": "40-80% OFF", "image": "images/sports_shoes.jpg"},
    {"title": "Shirts", "discount": "40-80% OFF", "image": "images/shirts.jpg"},
    {"title": "Jeans", "discount": "40-80% OFF", "image": "images/jeans.jpg"},
    {"title": "Track Pants", "discount": "50-80% OFF", "image": "images/track_pants.jpg"},
    {"title": "Belts & Wallets", "discount": "50-80% OFF", "image": "images/belts_wallets.jpg"},
    {"title": "Sunglasses", "discount": "40-80% OFF", "image": "images/sunglasses.jpg"},
  ];
});

final splashStateProvider = StateProvider<bool>((ref) => true);  
