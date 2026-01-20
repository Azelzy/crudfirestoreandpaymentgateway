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
    return Scaffold(
      appBar: AppBar(title: const Text('List Of Foods')),
      body: StreamBuilder<List<FoodModels>>(
        stream: controller.foods,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final foods = snapshot.data!;

          if (foods.isEmpty) {
            return const Center(child: Text('No foods available. Add one!'));
          }

          return RefreshIndicator(
            onRefresh: () {
              return Future.delayed(const Duration(seconds: 1));
            },
            child: ListView.builder(
              itemCount: foods.length,
              itemBuilder: (context, i) {
                return FoodCard(food: foods[i], controller: controller);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.clearControllers();
          Get.to(() => AddFoodPage(controller: controller));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
