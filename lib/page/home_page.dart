import 'package:crudfirestoreandpaymentgateway/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/food_models.dart';
import '../widgets/food_card.dart';
import 'add_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = HomeController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: isTablet ? null : AppBar(
        title: const Text('FOOD MENU'),
        toolbarHeight: 60,
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3),
        ),
        child: StreamBuilder<List<FoodModels>>(
          stream: controller.foods,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 4,
                ),
              );
            }

            final foods = snapshot.data!;

            if (foods.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEB8D9F),
                        border: Border.all(color: Colors.black, width: 3),
                      ),
                      child: const Icon(
                        Icons.restaurant_menu,
                        size: 80,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'NO FOODS\nAVAILABLE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1,
                      ),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              color: Colors.black,
              backgroundColor: const Color(0xFFBDDAF0),
              onRefresh: () {
                return Future.delayed(const Duration(seconds: 1));
              },
              child: isTablet
                  ? GridView.builder(
                      padding: const EdgeInsets.all(24),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: screenWidth > 900 ? 3 : 2,
                        childAspectRatio: 0.85,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: foods.length,
                      itemBuilder: (context, i) {
                        return FoodCard(food: foods[i], controller: controller);
                      },
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: foods.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: FoodCard(food: foods[i], controller: controller),
                        );
                      },
                    ),
            );
          },
        ),
      ),
      floatingActionButton: Container(
        width: isTablet ? 64 : 60,
        height: isTablet ? 64 : 60,
        decoration: BoxDecoration(
          color: const Color(0xFF9B97D1),
          border: Border.all(color: Colors.black, width: 3),
        ),
        child: IconButton(
          iconSize: isTablet ? 28 : 26,
          onPressed: () {
            controller.clearControllers();
            Get.to(() => AddFoodPage(controller: controller));
          },
          icon: const Icon(Icons.add, color: Colors.black),
        ),
      ),
    );
  }
}