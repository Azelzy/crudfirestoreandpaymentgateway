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

  // Observable loading state
  final isLoading = false.obs;
  
  // Observable foods list
  final foods = <FoodModels>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFoods();
  }

  void loadFoods() {
    _repository.getFood().listen((foodList) {
      foods.value = foodList;
    });
  }

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

      isLoading.value = true;

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
    } finally {
      isLoading.value = false;
    }
  }

  void deleteFood(String id) async {
    try {
      isLoading.value = true;
      await _repository.deleteFood(id);
      SnackbarHelper.showSuccess('Food deleted successfully!');
    } catch (e) {
      SnackbarHelper.showError('Failed to delete food: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    foodnameController.dispose();
    descriptionController.dispose();
    foodurlController.dispose();
    priceController.dispose();
    super.onClose();
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

      isLoading.value = true;

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
    } finally {
      isLoading.value = false;
    }
  }

  void clearControllers() {
    foodnameController.clear();
    descriptionController.clear();
    foodurlController.clear();
    priceController.clear();
  }
}