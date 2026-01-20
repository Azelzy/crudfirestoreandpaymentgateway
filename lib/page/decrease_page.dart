import 'package:flutter/material.dart';
import '../controller/home_controller.dart';

class EditFoodPage extends StatelessWidget {
  final String foodId;
  final HomeController controller;

  const EditFoodPage({
    super.key,
    required this.foodId,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Food')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller.foodnameController,
              decoration: const InputDecoration(labelText: 'Food Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller.descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller.foodurlController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller.priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.updateFood(context, foodId),
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
