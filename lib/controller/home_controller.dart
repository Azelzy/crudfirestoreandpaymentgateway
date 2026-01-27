// ignore_for_file: annotate_overrides, must_call_super

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../models/food_models.dart';
import '../repository/food_repository.dart';
import '../utils/snackbar_helper.dart';

class HomeController extends GetxController {
  final FoodRepository _repository = FoodRepository();

  final foodnameController = TextEditingController();
  final descriptionController = TextEditingController();
  final foodurlController = TextEditingController();
  final priceController = TextEditingController();

  Stream<List<FoodModels>> get foods => _repository.getFood();

  void addFood(BuildContext context) async {
    try {
      // Validation
      if (foodnameController.text.trim().isEmpty) {
        SnackbarHelper.showError('Food name cannot be empty!');
        return;
      }
      if (descriptionController.text.trim().isEmpty) {
        SnackbarHelper.showError('Description cannot be empty!');
        return;
      }
      if (foodurlController.text.trim().isEmpty) {
        SnackbarHelper.showError('Image URL cannot be empty!');
        return;
      }
      if (priceController.text.trim().isEmpty) {
        SnackbarHelper.showError('Price cannot be empty!');
        return;
      }

      final price = int.tryParse(priceController.text);
      if (price == null || price <= 0) {
        SnackbarHelper.showError('Please enter a valid price!');
        return;
      }

      await _repository.addFood(
        FoodModels(
          id: '',
          foodname: foodnameController.text.trim(),
          description: descriptionController.text.trim(),
          foodurl: foodurlController.text.trim(),
          price: price,
        ),
      );

      foodnameController.clear();
      descriptionController.clear();
      foodurlController.clear();
      priceController.clear();

      if (context.mounted) {
        Navigator.pop(context);
      }
      SnackbarHelper.showSuccess('Food added successfully!');
    } catch (e) {
      SnackbarHelper.showError('Failed to add food: ${e.toString()}');
    }
  }

  void deleteFood(String id) async {
    try {
      await _repository.deleteFood(id);
      SnackbarHelper.showSuccess('Food deleted successfully!');
    } catch (e) {
      SnackbarHelper.showError('Failed to delete food: ${e.toString()}');
    }
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

  void updateFood(BuildContext context, String id) async {
    try {
      // Validation
      if (foodnameController.text.trim().isEmpty) {
        SnackbarHelper.showError('Food name cannot be empty!');
        return;
      }
      if (descriptionController.text.trim().isEmpty) {
        SnackbarHelper.showError('Description cannot be empty!');
        return;
      }
      if (foodurlController.text.trim().isEmpty) {
        SnackbarHelper.showError('Image URL cannot be empty!');
        return;
      }
      if (priceController.text.trim().isEmpty) {
        SnackbarHelper.showError('Price cannot be empty!');
        return;
      }

      final price = int.tryParse(priceController.text);
      if (price == null || price <= 0) {
        SnackbarHelper.showError('Please enter a valid price!');
        return;
      }

      await _repository.updateFood(
        FoodModels(
          id: id,
          foodname: foodnameController.text.trim(),
          description: descriptionController.text.trim(),
          foodurl: foodurlController.text.trim(),
          price: price,
        ),
      );

      foodnameController.clear();
      descriptionController.clear();
      foodurlController.clear();
      priceController.clear();

      if (context.mounted) {
        Navigator.pop(context);
      }
      SnackbarHelper.showSuccess('Food updated successfully!');
    } catch (e) {
      SnackbarHelper.showError('Failed to update food: ${e.toString()}');
    }
  }

  void clearControllers() {
    foodnameController.clear();
    descriptionController.clear();
    foodurlController.clear();
    priceController.clear();
  }
}
