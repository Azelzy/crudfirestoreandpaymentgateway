class FoodModels {
  final String id;
  final String description;
  final String foodname;
  final String foodurl;
  final int price;

  FoodModels({
    required this.id,
    required this.description,
    required this.foodname,
    required this.foodurl,
    required this.price,
  });

  factory FoodModels.fromFirestore(String id, Map<String, dynamic> data) {
    return FoodModels(
      id: id,
      description: data['description'],
      foodname: data['foodname'],
      foodurl: data['foodurl'],
      price: data['price'],
    );
  }
}
