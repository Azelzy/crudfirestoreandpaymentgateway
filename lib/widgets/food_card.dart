import 'package:flutter/material.dart';
import '../controller/home_controller.dart';
import '../models/food_models.dart';
import 'package:get/get.dart';

class FoodCard extends StatelessWidget {
  final FoodModels food;
  final HomeController controller;

  const FoodCard({super.key, required this.food, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Image.network(
          food.foodurl,
          width: 55,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => const Icon(Icons.restaurant, size: 40),
        ),
        title: Text(
          food.foodname,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Rp${food.price}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => controller.deleteFood(food.id),
        ),
        onTap: () {
          controller.fillForEdit(food);

          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Edit Food'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller.foodnameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Makanan',
                    ),
                  ),
                  TextField(
                    controller: controller.descriptionController,
                    decoration: const InputDecoration(labelText: 'Deskripsi'),
                  ),
                  TextField(
                    controller: controller.priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Harga'),
                  ),
                  TextField(
                    controller: controller.foodurlController,
                    decoration: const InputDecoration(labelText: 'URL Gambar'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () => controller.updateFood(context, food.id),
                  child: const Text('Update'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
