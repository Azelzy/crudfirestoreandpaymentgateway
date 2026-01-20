import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudfirestoreandpaymentgateway/models/food_models.dart';

class FoodRepository {
  final _ref = FirebaseFirestore.instance.collection('food');
  
  Stream<List<FoodModels>> getFood() {
    return _ref.snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => FoodModels.fromFirestore(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<void> addFood(FoodModels food) {
    return _ref.add({
      'description': food.description,
      'foodname': food.foodname,
      'foodurl': food.foodurl,
      'price': food.price,
    });
  }

  Future<void> deleteFood(String id) {
    return _ref.doc(id).delete();
  }

  Future<void> updateFood(FoodModels food) {
    return _ref.doc(food.id).update({
      'description': food.description,
      'foodname': food.foodname,
      'foodurl': food.foodurl,
      'price': food.price,
    });
  }
}
