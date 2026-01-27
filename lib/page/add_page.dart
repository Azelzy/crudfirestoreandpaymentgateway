import 'package:flutter/material.dart';
import '../controller/home_controller.dart';
import '../widgets/button_widget.dart';

class AddFoodPage extends StatelessWidget {
  final HomeController controller;

  const AddFoodPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD FOOD'),
        toolbarHeight: isTablet ? 80 : 60,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isTablet ? 32 : 16),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: isTablet ? 600 : double.infinity,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(isTablet ? 16 : 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEB8D9F),
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                    child: Text(
                      'NEW ITEM',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isTablet ? 24 : 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  SizedBox(height: isTablet ? 32 : 24),
                  
                  _buildLabel('FOOD NAME'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller.foodnameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter food name',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: isTablet ? 20 : 16),
                  
                  _buildLabel('DESCRIPTION'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller.descriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Enter description',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                    maxLines: 4,
                  ),
                  SizedBox(height: isTablet ? 20 : 16),
                  
                  _buildLabel('IMAGE URL'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller.foodurlController,
                    decoration: const InputDecoration(
                      hintText: 'https://example.com/image.jpg',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: isTablet ? 20 : 16),
                  
                  _buildLabel('PRICE (Rp)'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller.priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter price',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: isTablet ? 32 : 24),
                  
                  AppButton(
                    text: 'SAVE FOOD',
                    backgroundColor: const Color(0xFF9B97D1),
                    onPressed: () => controller.addFood(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFBDDAF0),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}