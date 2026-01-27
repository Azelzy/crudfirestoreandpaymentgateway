import 'package:flutter/material.dart';
import '../controller/home_controller.dart';
import '../models/food_models.dart';

class FoodCard extends StatelessWidget {
  final FoodModels food;
  final HomeController controller;

  const FoodCard({super.key, required this.food, required this.controller});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return GestureDetector(
      onTap: () {
        controller.fillForEdit(food);
        _showEditDialog(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFCDCB3),
          border: Border.all(color: Colors.black, width: 3),
        ),
        child: isTablet
            ? _buildTabletLayout(context)
            : _buildMobileLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 3),
            ),
            child: Image.network(
              food.foodurl,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) =>
                  const Icon(Icons.restaurant, size: 40, color: Colors.black),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.foodname.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  food.description,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFBDDAF0),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Text(
                    'Rp ${food.price}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFEB8D9F),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.delete, size: 20),
              onPressed: () => _showDeleteDialog(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: Image.network(
                food.foodurl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (_, _, _) =>
                    const Icon(Icons.restaurant, size: 60, color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            food.foodname.toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFBDDAF0),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Text(
              'Rp ${food.price}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFFFFF2D6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: const BorderSide(color: Colors.black, width: 3),
        ),
        title: const Text(
          'DELETE?',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        content: Text('Delete ${food.foodname}?'),
        actions: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'CANCEL',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFEB8D9F),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: TextButton(
              onPressed: () {
                controller.deleteFood(food.id);
                Navigator.pop(context);
              },
              child: const Text(
                'DELETE',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFFFFF2D6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: const BorderSide(color: Colors.black, width: 3),
        ),
        title: const Text(
          'EDIT FOOD',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        content: SizedBox(
          width: isTablet ? 500 : double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller.foodnameController,
                  decoration: const InputDecoration(labelText: 'FOOD NAME'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: controller.descriptionController,
                  decoration: const InputDecoration(labelText: 'DESCRIPTION'),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: controller.priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'PRICE'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: controller.foodurlController,
                  decoration: const InputDecoration(labelText: 'IMAGE URL'),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'CANCEL',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF9B97D1),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: TextButton(
              onPressed: () => controller.updateFood(context, food.id),
              child: const Text(
                'UPDATE',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
