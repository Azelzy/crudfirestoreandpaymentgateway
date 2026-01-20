import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../models/food_models.dart';
import '../repository/food_repository.dart';

class HomeController extends GetxController {
  final FoodRepository _repository = FoodRepository();

  //  final String id;
  // final String description;
  // final String foodname;
  // final int foodurl;
  // final String price;

  final foodnameController = TextEditingController();
  final descriptionController = TextEditingController();
  final foodurlController = TextEditingController();
  final priceController = TextEditingController();

  Stream<List<FoodModels>> get foods => _repository.getFood();

  void addFood(BuildContext context) {
    _repository.addFood(
      FoodModels(
        id: '',
        foodname: foodnameController.text,
        description: descriptionController.text,
        foodurl: foodurlController.text,
        price: int.parse(priceController.text),
      ),
    );

    foodnameController.clear();
    descriptionController.clear();
    foodurlController.clear();
    priceController.clear();

    Navigator.pop(context);
  }

  void deleteFood(String id) {
    _repository.deleteFood(id);
  }

  void dispose() {
    foodnameController.dispose();
    descriptionController.dispose();
    foodurlController.dispose();
    priceController.dispose();
  }

  void fillForEdit(FoodModels food) {
    foodnameController.text = food.foodname;
    descriptionController.text = food.description;
    foodurlController.text = food.foodurl;
    priceController.text = food.price.toString();

  }

  void updateFood(BuildContext context, String id) {
    _repository.updateFood(
      FoodModels(
        id: id,
        foodname: foodnameController.text,
        description: descriptionController.text,
        foodurl: foodurlController.text,
        price: int.parse(priceController.text),
      ),
    );

    foodnameController.clear();
    descriptionController.clear();
    foodurlController.clear();
    priceController.clear();

    Navigator.pop(context);
  }

  void clearControllers() {
    foodnameController.clear();
    descriptionController.clear();
    foodurlController.clear();
    priceController.clear();
  }

}
